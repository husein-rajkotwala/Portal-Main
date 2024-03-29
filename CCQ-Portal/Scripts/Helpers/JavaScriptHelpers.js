﻿var RSVP = require('rsvp');

SJH = {};

SJH.Status = {};

SJH.Status.retryingSecurityValidation = false;

SJH.Status.lastSiteUsed = "";

SJH.Config = { errorAlerts: true };

SJH.Utils = {};

SJH.Utils.getContext = function (site) {
    if (site) {
        return new SP.ClientContext(site);
    } else {
        return new SP.ClientContext.get_current();
    }
};

SJH.spread = function (callback) {
    return function (arr) {
        callback.apply(null, arr);
    };
};

SJH.all = function (promises) {
    return RSVP.all(promises);
};

SJH.executeQueryAsync = function (context, resolve, reject, returnValue) {
    var originalArguments = arguments;
    context.executeQueryAsync(
        function () {
            var returnValueResolved = returnValue && returnValue();
            resolve(returnValueResolved);
        },
        function (sender, args) {
            SJH.error(sender, args, reject, resolve, SJH.executeQueryAsync, originalArguments);
        });
};

SJH.addListItem = function (options) {
    return new RSVP.Promise(function (resolve, reject) {
        var context = SJH.Utils.getContext(options.site);
        SJH.Status.lastSiteUsed = options.site;
        var list = context.get_web().get_lists().getByTitle(options.list);
        var itemCreateInfo = new SP.ListItemCreationInformation();
        var listItem = list.addItem(itemCreateInfo);

        for (var key in options.data) {
            if (options.data.hasOwnProperty(key)) {
                listItem.set_item(key, options.data[key]);
            }
        }

        listItem.update();

        context.load(listItem); /* loading the item gets its ID */

        SJH.executeQueryAsync(context, resolve, reject, function () { return listItem.get_id() });
    });
};

SJH.getListItems = function (options) {
    var originalArguments = arguments;
    return new RSVP.Promise(function (resolve, reject) {
        var context = SJH.Utils.getContext(options.site);
        SJH.Status.lastSiteUsed = options.site;
        var web = context.get_web();
        var listObject = web.get_lists().getByTitle(options.list);

        var camlQuery = new SP.CamlQuery();

        camlQuery.set_viewXml(options.query);

        var listItems = listObject.getItems(camlQuery);

        context.load(listItems, "Include(" + options.fields + ")");

        context.executeQueryAsync(function () {
            var listItemArray = [];
            var listItemEnumerator = listItems.getEnumerator();

            while (listItemEnumerator.moveNext()) {
                var listItem = listItemEnumerator.get_current();
                var listItemAsObject = {};
                for (index = 0; index < options.fields.length; ++index) {
                    if (options.fields[index].toLowerCase() == "id") {
                        listItemAsObject[options.fields[index]] = listItem.get_id();
                    } else if (options.fields[index].toLowerCase() == "displayname") {
                        listItemAsObject[options.fields[index]] = listItem.get_displayName();
                    } else {
                        listItemAsObject[options.fields[index]] = listItem.get_item(options.fields[index]);
                    }
                }
                listItemAsObject.object = listItem;
                listItemArray.push(listItemAsObject);
            }
            return resolve(listItemArray);

        },
            function (sender, args) {
                SJH.error(sender, args, reject, resolve, SJH.getListItems, originalArguments);
            });
    });
};

SJH.updateListItem = function (options) {
    return new RSVP.Promise(function (resolve, reject) {
        var context = SJH.Utils.getContext(options.site);
        SJH.Status.lastSiteUsed = options.site;
        var list = context.get_web().get_lists().getByTitle(options.list);
        var listItem = list.getItemById(options.id);

        for (var key in options.data) {
            if (options.data.hasOwnProperty(key)) {
                listItem.set_item(key, options.data[key]);
            }
        }

        listItem.update();

        SJH.executeQueryAsync(context, resolve, reject);
    });
};

SJH.deleteListItem = function (options) {
    return new RSVP.Promise(function (resolve, reject) {
        var context = SJH.Utils.getContext(options.site);
        SJH.Status.lastSiteUsed = options.site;
        var list = context.get_web().get_lists().getByTitle(options.list);
        var listItem = list.getItemById(options.id);

        listItem.deleteObject();

        SJH.executeQueryAsync(context, resolve, reject);
    });
};

SJH.getCurrentUserEmail = function (options) {
    return new RSVP.Promise(function (resolve, reject) {
        var context = SJH.Utils.getContext((options && options.site) || null);
        SJH.Status.lastSiteUsed = options.site;
        var web = context.get_web();
        var currentUser = web.get_currentUser();

        context.load(currentUser);

        SJH.executeQueryAsync(context, resolve, reject, function () { return currentUser.get_email() });
    });
};

SJH.error = function (sender, args, reject, resolve, functionForRetry, argumentsForRetry) {
    var message = (args && args.get_message()) || "";
    var stackTrace = (args && args.get_stackTrace()) || "";

    /* If action failed due to security validation error, get 
    new validation and retry once */
    if (message.indexOf("security validation") >= 0 &&
        SJH.Status.retryingSecurityValidation === false &&
        functionForRetry && argumentsForRetry) {
        SJH.Status.retryingSecurityValidation = true;
        UpdateFormDigest(SJH.Status.lastSiteUsed || "/");
        resolve(functionForRetry.apply(null, [argumentsForRetry[0]]));
        SJH.Status.retryingSecurityValidation = false;
        if (window.console) {
            console.log("Updated security validation");
        }
        return;
    }

    if (SJH.Config.errorAlerts) {
        alert("An error has occurred." + '\n\n' + message +
            stackTrace);
    }

    reject && reject();
};

RSVP.on("error", function (reason) {
    if (SJH.Config.errorAlerts && window.console && reason) {
        console.assert(false, reason);
    }
});
