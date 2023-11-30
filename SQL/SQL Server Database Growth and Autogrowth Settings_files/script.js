$(document).ready(function() {
    $("#RSSfeedwidget").show();
});

function RssSelect(category) {
    if (category.value.indexOf("-") == -1) {
        $("input[name*='rss'][value^='" + category.value + "-']").each(function () {
                this.checked = category.checked
        });
    }
    else {
        if (category.checked == false) {
            $("input[name*='rss'][value='" + category.value.substring(0, category.value.indexOf("-")) + "']").each(function () {
                this.checked = false;
            });
        }
    }
}

function RssGetSide(isAdvanced) {
    if (isAdvanced == false && $("a#rssGetLink").length != 0) {
        var nCat = "?ncat";

        $("input[name*='rss']").each(function () {
            if (this.checked == false) {
                nCat += (nCat == "?ncat" ? "=" : ",") + $(this).val();
            }
        });

        var baselink = $("a#rssGetLink").attr("href").substring(0, $("a#rssGetLink").attr("href").indexOf("rss.aspx") + 8);
        document.location.href = baselink + nCat;
    }

    if (isAdvanced == true && $("a#rssAdvLink").length != 0) {
        var sCat = "?scat";

        $("input[name*='rss']").each(function () {
            if (this.checked == true) {
                sCat += (sCat == "?scat" ? "=" : ",") + $(this).val();
            }
        });

        var baselink = $("a#rssAdvLink").attr("href").substring(0, $("a#rssAdvLink").attr("href").indexOf("rsssel.aspx") + 11);
        document.location.href = baselink + sCat;
    }
}

function RssGetMain() {
    if ($("a#rssGetLink").length != 0) {
        var nonCat = new Array();

        $("input[name*='rss']").each(function () {
            if ($(this).val().indexOf("-") == -1) {
                if ($(this).val() == "B") { // blogs are special case as it has no children
                    if (this.checked == false) nonCat[nonCat.length] = $(this).val()
                }
                else {
                    var children = new Array();
                    var childSelected = false;
                    $("input[name*='rss'][value^='" + $(this).val() + "-']").each(function () {
                        if (this.checked == true) {
                            childSelected = true;
                        }
                        else {
                            children[children.length] = $(this).val().substring($(this).val().indexOf("-") + 1);
                        }
                    });
                    if (childSelected == false) {
                        nonCat[nonCat.length] = $(this).val();
                    }
                    else {
                        for (loop = 0; loop < children.length; loop++) {
                            nonCat[nonCat.length] = children[loop];
                        }
                    }
                }
            }
        });

        var categories = "?ncat";
        $.each(nonCat, function (index, value) { categories += (categories == "?ncat" ? "=" : ",") + value; });

        var baselink = $("a#rssGetLink").attr("href").substring(0, $("a#rssGetLink").attr("href").indexOf("rss.aspx") + 8);
        document.location.href = baselink + categories;
    }
}

$(document).ready(function() {
    var entireCornerPeel =  $("#corner-peel"),
        cornerPeelFront = $("#corner-peel img"),
        cornerPeelBehind = $("#corner-peel-behind"),
        bringCornerPeelToFront = function() {
            entireCornerPeel.css({"z-index": 200});
        },
        bringCornerPeelToBack = function() {
            entireCornerPeel.css({"z-index": 50});
        },
        resizeCornerPeelToDefault = function() {
            cornerPeelFront.stop().animate({
                width: '82px',
                height: '85px'
            }, 220);
            cornerPeelBehind.stop().animate({
                width: '80px',
                height: '80px'
            }, 200, bringCornerPeelToBack); //Note this one retracts a bit faster (to prevent glitching in IE)
        };
    if (location.pathname === "/") {
        setTimeout(function() {
            cornerPeelFront.stop().animate({
                width: '125px',
                height: '125px'
            }, 500);

            cornerPeelBehind.stop().animate({
                width: '122px',
                height: '120px'
            }, 500, function() {
                setTimeout(resizeCornerPeelToDefault, 1000);
            });
        }, 1000);
    }

   entireCornerPeel.hover(function() {
        $([cornerPeelFront.get(0), cornerPeelBehind.get(0)]).stop().animate({
            width: '307px',
            height: '318px'
        }, 500);
        bringCornerPeelToFront();
    }, resizeCornerPeelToDefault);
});

$(document).ready(function() {
    $(".show-on-ready").show();
});