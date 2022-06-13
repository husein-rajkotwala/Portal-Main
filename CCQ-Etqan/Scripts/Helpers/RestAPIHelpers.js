"use strict";
var RESTApiHelper = window.RESTApiHelper || {};

var FieldType = {
    Invalid: 0,
    Integer: 1,
    Text: 2,
    Note: 3,
    DateTime: 4,
    Counter: 5,
    Choice: 6,
    Lookup: 7,
    Boolean: 8,
    Number: 9,
    Currency: 10,
    URL: 11,
    Computed: 12,
    Threading: 13,
    Guid: 14,
    MultiChoice: 15,
    GridChoice: 16,
    Calculated: 17,
    File: 18,
    Attachments: 19,
    User: 20,
    Recurrence: 21,
    CrossProjectLink: 22,
    ModStat: 23,
    Error: 24,
    ContentTypeId: 25,
    PageSeparator: 26,
    ThreadIndex: 27,
    WorkflowStatus: 28,
    AllDayEvent: 29,
    WorkflowEventType: 30,
    MaxItems: 31
};


RESTApiHelper.Web = function (SiteUrl) {
    this.SiteUrl = SiteUrl;

    this.GetWeb = function (doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web",
            type: "GET",
            headers: { "accept": "application/json;odata=verbose" },
            success: doSuccess,
            error: doError
        });
    }

    this.GetAllSubWebs = function (doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web/webs",
            type: "GET",
            headers: { "accept": "application/json;odata=verbose" },
            success: doSuccess,
            error: doError
        });
    }

    this.GetWebProperty = function (propertyName, doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web/" + propertyName,
            type: "GET",
            headers: { "accept": "application/json;odata=verbose" },
            success: doSuccess,
            error: doError
        });
    }

    this.CreateSubsite = function (Title, Url, Description, WebTemplate, UseUniquePermissions, doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web/webinfos/add",
            type: "POST",
            data: JSON.stringify({
                'parameters': {
                    '__metadata': { 'type': 'SP.WebInfoCreationInformation' },
                    'Title': Title,
                    'Url': Url,
                    'Description': Description,
                    'Language': 1033,
                    'WebTemplate': WebTemplate,
                    'UseUniquePermissions': UseUniquePermissions
                }
            }),
            headers: {
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                "accept": "application/json;odata=verbose",
                "content-type": "application/json;odata=verbose",
                "content-length": 1000
            },
            success: doSuccess,
            error: doError
        });
    }

    this.UpdateSite = function (Description, doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web",
            type: "POST",
            data: JSON.stringify({
                '__metadata': { 'type': 'SP.Web' }, 'Description': Description,
                'EnableMinimalDownload': false
            }),
            headers: {
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                "accept": "application/json;odata=verbose",
                "content-type": "application/json;odata=verbose",
                "content-length": 100,
                "X-HTTP-Method": "MERGE"
            },
            success: doSuccess,
            error: doError
        });
    }

    this.DeleteSite = function (doSuccess, doError) {
        $.ajax({
            url: SiteUrl + "/_api/web",
            type: "POST",
            headers: {
                "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                "X-HTTP-Method": "DELETE"
            },
            success: doSuccess,
            error: doError
        });
    }

    this.GetAllList = function (doSuccess, doError) {
        jQuery.ajax({
            url: SiteUrl + "/_api/web/lists",
            type: "GET",
            headers: {
                "accept": "application/json;odata=verbose"
            },
            success: doSuccess,
            error: doError
        });
    }

    this.CreateList = function (ListTitle, ListDescription, doSuccess, doError) {
        jQuery.ajax({
            url: SiteUrl + "/_api/web/lists",
            type: "POST",
            data: JSON.stringify({
                '__metadata': { 'type': 'SP.List' }, 'AllowContentTypes': true,
                'BaseTemplate': 100, 'ContentTypesEnabled': true, 'Description': ListDescription, 'Title': ListTitle
            }),
            headers: {
                "accept": "application/json;odata=verbose",
                "content-type": "application/json;odata=verbose",
                "content-length": 100,
                "X-RequestDigest": $("#__REQUESTDIGEST").val()
            },
            success: doSuccess,
            error: doError
        });
    }

    this.List = function (ListName) {
        this.ListName = ListName;

        this.Fields = function () {
            this.GetAllFields = function (doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields",
                    type: "GET",
                    headers: { "accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFieldByName = function (FieldName, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')",
                    type: "GET",
                    headers: { "accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFieldByGuid = function (FieldGuid, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields('" + FieldGuid + "')",
                    type: "GET",
                    headers: { "accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.FieldProperty = function (FieldName, PropertyName, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')/" + PropertyName,
                    type: "GET",
                    headers: { "accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.FieldMethod = function (FieldName, MethodName, Parameter, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')/" + MethodName + "(" + Parameter + ")",
                    type: "POST",
                    headers: { "X-RequestDigest": $("#__REQUESTDIGEST").val() },
                    success: doSuccess,
                    error: doError
                });
            }

            this.AddField = function (FieldName, FieldTypeKind, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields",
                    type: "POST",
                    data: JSON.stringify({ '__metadata': { 'type': 'SP.Field' }, 'Title': FieldName, 'FieldTypeKind': FieldTypeKind }),
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "accept": "application/json; odata=verbose",
                        "content-type": "application/json;odata=verbose",
                        "content-length": 100
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.AddFieldAsXML = function (FieldName, FieldTypeKind, SchemaXml, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields",
                    type: "POST",
                    data: JSON.stringify({
                        '__metadata': { 'type': 'SP.Field' },
                        'FieldTypeKind': FieldTypeKind, 'Title': FieldName, 'SchemaXml': SchemaXml
                    }),
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "accept": "application/json; odata=verbose",
                        "content-type": "application/json;odata=verbose",
                        "content-length": 100
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.AddFieldAsMetadata = function (metadatadoSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields",
                    type: "POST",
                    data: metadata,
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "accept": "application/json; odata=verbose",
                        "content-type": "application/json;odata=verbose",
                        "content-length": 100
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.UpdateField = function (FieldName, NewTitle, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')",
                    type: "POST",
                    data: "{ '__metadata': { 'type': 'SP.Field' }, 'Title': NewTitle }",
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "content-type": "application/json;odata=verbose",
                        "content-length": 100,
                        "X-HTTP-Method": "MERGE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.UpdateFieldAsMetadata = function (FieldName, Metadata, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')",
                    type: "POST",
                    data: Metadata,
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "content-type": "application/json;odata=verbose",
                        "content-length": 100,
                        "X-HTTP-Method": "MERGE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.DeleteField = function (FieldName, doSuccess, doError) {
                $.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/fields/getbytitle('" + FieldName + "')",
                    type: "POST",
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "X-HTTP-Method": "DELETE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }
        }

        this.GetList = function (doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')",
                type: "GET",
                headers: {
                    "accept": "application/json;odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.UpdateList = function (NewListTitle, NewListDescription, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')",
                type: "POST",
                data: JSON.stringify({
                    '__metadata': { 'type': 'SP.List' }, 'AllowContentTypes': true,
                    'BaseTemplate': 100, 'ContentTypesEnabled': true, 'Description': NewListDescription, 'Title': NewListTitle
                }
                ),
                headers: {
                    "IF-MATCH": "*",
                    "X-HTTP-Method": "MERGE",
                    "content-type": "application/json;odata=verbose",
                    "X-RequestDigest": $("#__REQUESTDIGEST").val()
                },
                success: doSuccess,
                error: doError
            });
        }

        this.DeleteList = function (doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')",
                type: "POST",
                headers: {
                    "IF-MATCH": "*",
                    "X-HTTP-Method": "DELETE",
                    "content-type": "application/json;odata=verbose",
                    "X-RequestDigest": $("#__REQUESTDIGEST").val()
                },
                success: doSuccess,
                error: doError
            });
        }

        this.ListItemEntityTypeFullName = function (doError) {
            var listItemEntityTypeFullName = '';
            jQuery.ajax({
                url: SiteUrl + "/_api/web/lists/GetByTitle('" + this.ListName + "')/listItemEntityTypeFullName",
                type: "GET",
                headers: {
                    "accept": "application/json;odata=verbose"
                },
                success: function (data) {
                    listItemEntityTypeFullName = data.d.ListItemEntityTypeFullName;
                },
                error: doError
            });

            return listItemEntityTypeFullName;
        }

        this.Items = function () {
            this.GetAllItems = function (doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + ListName + "')/items",
                    type: "GET",
                    headers: { "Accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetItems = function (select, filter,orderBy,top, doSuccess, doError) {
               var urlfilter = "";
                var urlorderBy = "";
                var  urlTop= "";
                if (select != '') {
                    urlfilter = "?$select=" + select;
                }
                if (filter != '') {
                    if (urlfilter != '')
                        urlfilter = urlfilter + "&$filter=" + filter;
                    else
                        urlfilter = "?$filter=" + filter;
                }
				if (orderBy != '') {
                if (urlfilter != '') 
                    urlorderBy = urlorderBy + "&$orderby=" + orderBy;                
                else 
                        urlorderBy = "?$orderby=" + orderBy;
                }
				
				if (top != '') {
                if (urlorderBy != '')
                    urlTop = urlTop + "&$top=" + top;
                else 
                        urlTop = "?$top=" + top;
                }

                jQuery.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + ListName + "')/items" + urlfilter + urlorderBy + urlTop,
                    type: "GET",
                    headers: { "Accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetItemsByCaml = function (ViewXML, OnSuccess, OnError) {
                var serviceUrl = SiteUrl + "/_api/web/lists/GetByTitle('" + ListName + "')/getitems";

                var metadata = JSON.stringify({ 'query': { '__metadata': { 'type': 'SP.CamlQuery' }, 'ViewXml': ViewXML } });

                jQuery.ajax({
                    url: serviceUrl,
                    type: "POST",
                    data: metadata,
                    headers: {
                        "X-RequestDigest": $("#__REQUESTDIGEST").val(),
                        "Accept": "application/json; odata=verbose",
                        "content-type": "application/json; odata=verbose",
                        "content-length": metadata.length
                    },
                    success: OnSuccess,
                    error: OnError
                });
            }

            this.GetItemByID = function (ItemId, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + ListName + "')/getitembyid(" + ItemId + ")",
                    type: "GET",
                    headers: { "Accept": "application/json; odata=verbose" },
                    success: doSuccess,
                    error: doError
                });
            }

            this.AddItem = function (title, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/lists/GetByTitle('" + ListName + "')/items",
                    type: "POST",
                    data: JSON.stringify({ '__metadata': { 'type': 'SP.Data.TestListListItem' }, 'Title': title }),
                    headers: {
                        "accept": "application/json;odata=verbose",
                        "content-type": "application/json; odata=verbose",
                        "X-RequestDigest": $("#__REQUESTDIGEST").val()
                    },
                    success: doSuccess,
                    error: doError
                });

            }

        }

        this.Files = function (folderUrl) {
            this.FolderUrl = folderUrl;
            this.GetAllFiles = function (doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')/Files",
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFileMetadataByUrl = function (FileName, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')/Files('" + FileName + "')",
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFileContentByUrl = function (FileName, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')/Files('" + FileName + "')/$value",
                    type: "GET",
                    binaryStringResponseBody: true,
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFileByServerRelativeUrl = function (FileUrl, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfilebyserverrelativeurl('" + FileUrl + "')",
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFilePropertyByServerRelativeUrl = function (FileUrl, PropertyName, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfilebyserverrelativeurl('" + FileUrl + "')/" + PropertyName,
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.UpdateFileContentByServerRelativeUrl = function (FileUrl, FileContent) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfilebyserverrelativeurl('" + FileUrl + "')/$value",
                    type: "POST",
                    body: FileContent,
                    headers: {
                        "accept": "application/json;odata=verbose",
                        "X-HTTP-Method": "PUT"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.AddFile = function (arrayBuffer, fileUrl, doSuccess, doError) {
                var fileData = '';
                var byteArray = new Uint8Array(arrayBuffer);
                for (var i = 0; i < byteArray.byteLength; i++) {
                    fileData += String.fromCharCode(byteArray[i]);
                }

                // Send the request.
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')/Files/add(overwrite=true, url='" + fileUrl + "')",
                    method: "POST",
                    body: fileData,
                    binaryStringRequestBody: true,
                    headers: { "accept": "application/json;odata=verbose" },
                    success: doSuccess,
                    error: doError
                });

            }

            this.DeleteFileByServerRelativeUrl = function (FileUrl, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfilebyserverrelativeurl('" + FileUrl + "')",
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose",
                        "X-HTTP-Method": "DELETE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }
        }

        this.Folders = function () {
            this.GetFolderByUrl = function (FolderUrl, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')",
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.GetFolderPropertiesByUrl = function (FolderUrl, PropertyName, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')/" + PropertyName,
                    type: "GET",
                    headers: {
                        "accept": "application/json;odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.UpdateFolderByUrl = function (FolderUrl, PropertyName, PropertyValue, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')",
                    type: "POST",
                    data: JSON.stringify({ '__metadata': { 'type': 'SP.Folder' }, PropertyName: PropertyValue }),
                    headers: {
                        "accept": "application/json;odata=verbose",
                        "content-type": "application/json; odata=verbose",
                        "X-HTTP-Method": "MERGE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.DeleteFolderByUrl = function (FolderUrl, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + FolderUrl + "')",
                    type: "POST",
                    headers: {
                        "X-HTTP-Method": "DELETE"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.CreateFolder = function (parentFolderUrl, NewFolderName, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/getfolderbyserverrelativeurl('" + parentFolderUrl + "')/folders",
                    type: "POST",
                    data: JSON.stringify({ '__metadata': { 'type': 'SP.Folder' }, 'ServerRelativeUrl': NewFolderName }),
                    headers: {
                        "accept": "application/json; odata=verbose",
                        "content-type": "application/json; odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }

            this.CreateFolderByAdd = function (NewFolderRelativeURL, doSuccess, doError) {
                jQuery.ajax({
                    url: SiteUrl + "/_api/web/folders/add('" + NewFolderRelativeURL + "')",
                    type: "POST",
                    headers: {
                        "accept": "application/json; odata=verbose",
                        "content-type": "application/json; odata=verbose"
                    },
                    success: doSuccess,
                    error: doError
                });
            }
        }
    }

    this.Users = function () {
        this.GetAllUsers = function (doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/SiteUsers",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetUserByLoginId = function (LoginId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/SiteUsers(@v)?@v='" + encodeURIComponent("i:0#.w|" + LoginId) + "'",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetUserByEmail = function (EmailId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/SiteUsers/GetUserByEmail('" + EmailId + "')",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetUserById = function (UserId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/GetUserById(" + UserId + ")",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetUserInGroupByLoginId = function (GroupId, LoginId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")/users(@v)?@v='" + encodeURIComponent("i:0#.w|" + LoginId) + "'",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.AddUserIntoGroup = function (GroupId, LoginId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")/users",
                method: "POST",
                data: JSON.stringify({ '__metadata': { 'type': 'SP.User' }, 'LoginName': 'i:0#.w|' + LoginId }),
                headers: {
                    "accept": "application/json; odata=verbose",
                    "content-type": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.RemoveUserByLoginId = function (LoginId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/removebyloginname(@v)?@v='" + encodeURIComponent("i:0#.w|" + LoginId) + "'",
                method: "POST",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.RemoveUserById = function (UserId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/removebyid(" + UserId + ")",
                method: "POST",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.RemoveUserFromGroupById = function (GroupId, UserId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")/removebyid(" + UserId + ")",
                method: "POST",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.RemoveUserFromGroupByName = function (GroupId, LoginId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")/removebyloginname(@v)?@v='" + encodeURIComponent("i:0#.w|" + LoginId) + "'",
                method: "POST",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }
    }

    this.Groups = function () {
        this.GetAllGroups = function (doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetGroupById = function (GroupId, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetGroupByName = function (GroupName, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups/getbyname('" + GroupName + "')",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.GetAllUsersInGroup = function (doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups(" + GroupId + ")/users",
                method: "GET",
                headers: {
                    "accept": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }

        this.CreateGroup = function (GroupName, doSuccess, doError) {
            jQuery.ajax({
                url: SiteUrl + "/_api/web/sitegroups",
                method: "POST",
                data: JSON.stringify({ '__metadata': { 'type': 'SP.Group' }, 'Title': GroupName }),
                headers: {
                    "content-type": "application/json; odata=verbose"
                },
                success: doSuccess,
                error: doError
            });
        }
    }
}