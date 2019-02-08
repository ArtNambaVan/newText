$( document ).ready(function() {

    var $tonalityPopup = $('.tonality-popup');

    $('.category__value').find('a').on('click', function(e) {
        e.preventDefault();
        var $item = $(this).closest('.category__item');
        var $popupHeading = $item.find('.category__name').text();
        var $tonalityPopup = $(this).closest('.category__item').find('.tonality-popup');
        $tonalityPopup.toggleClass('show');
        $tonalityPopup.find('.tonality-popup__header').text($popupHeading)
    });

    $tonalityPopup.find('.close').on('click', function(e) {
        e.preventDefault();
        $(this).closest($tonalityPopup).removeClass('show');
    })

    $('li.dropdown.mega-dropdown a').on('click', function (event) {
        $(this).parent().toggleClass('open');
    });

    $('.open-jstree').on('click', function(e) {
        $('#popup').addClass('show');
    })

    $('#popup').find('.close').on('click', function(e) {
        $('#popup').removeClass('show')
    })


    // $(function () {
    //     $('.datepicker').dropdown();
    //     $('.datepicker').click(function (e) {
    //         e.stopPropagation();
    //         return false;
    //     });
    // });

    $('.datepicker').on('click', function (e) {
        var target = $(e.target);
        console.log(target)
        if(target.hasClass("period__item") || target.hasClass("calendar") || target.parents(".calendar").length){
            return false; // returning false should stop the dropdown from hiding.
        }else{
            return true;
        }
    });






    $('#source').on('click', function (e) {
        var target = $(e.target);
        if(target.hasClass('jstree-anchor')){
            return true; 
        } else {
            e.stopPropagation();
            target.stopPropagation();
            return false;
        }
    });

    $('#source').jstree({
		'core' : {
			'data' : [
				{
					"text" : "first root node",
                    "state" : { "opened" : true },
                    "a_attr" : {
                        "class" : "jstree-rating"
                    },
					"children" : [
                        { "text" : "Child node 1",
                            "a_attr" : {
                                "class" : "jstree-rating"
                            },
                         },

                         { "text" : "Child node 2"
                         },

                         { "text" : "Child node 3"
                         },

                         { "text" : "Child node 4"
                         },

                         { "text" : "Child node 5",
                            "a_attr" : {
                                "class" : "jstree-rating"
                            },
                         },

						{ "text" : "Child node 6"}
					]
                },
                {
					"text" : "second root node",
					"state" : { "opened" : true },
					"children" : [
						{
							"text" : "Child node 1",
							"state" : { "opened" : true },
                            "icon" : "jstree-file",
                            "children" : [
                                {
                                    "text" : "Child node 11"
                                },
                                { "text" : "Child node 22"}
                            ]
						},
						{ "text" : "Child node 2"}
					]
				}
			]
		}
    });



    $('#jsTreeCategory').jstree({
		'core' : {
			'data' : [
				{
					"text" : "first root node",
                    "state" : { "opened" : true },
                    "a_attr" : {
                        "class" : "jstree-rating"
                    },
					"children" : [
                        { "text" : "Child node 1",
                            "a_attr" : {
                                "class" : "jstree-rating"
                            },
                         },

                         { "text" : "Child node 2"
                         },

                         { "text" : "Child node 3"
                         },

                         { "text" : "Child node 4"
                         },

                         { "text" : "Child node 5",
                            "a_attr" : {
                                "class" : "jstree-rating"
                            },
                         },

						{ "text" : "Child node 6"}
					]
                },
                {
					"text" : "second root node",
					"state" : { "opened" : true },
					"children" : [
						{
							"text" : "Child node 1",
							"state" : { "opened" : true },
                            "icon" : "jstree-file",
                            "children" : [
                                {
                                    "text" : "Child node 11"
                                },
                                { "text" : "Child node 22"}
                            ]
						},
						{ "text" : "Child node 2"}
					]
				}
			]
		}
    });
    
    $('#jsTreeCategory2').jstree({
		'core' : {
			'data' : [
				{ "text" : "Child node 1",
                "a_attr" : {
                    "class" : "jstree-rating"
                },
                },

                { "text" : "Child node 2",
                "a_attr" : {
                    "class" : "jstree-rating"
                }
            }
			]
		}
	});

    
});
