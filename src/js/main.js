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

    // $('.dropdown-toggle').on('click', function (event) {
    //     $(this).siblings('.dropdown-menu').toggleClass('show');
    // });



    $('#jsTreeCategory').jstree({
		'core' : {
			'data' : [
				{
					"text" : "first root node",
                    "state" : { "opened" : true },
                    "a_attr" : {
                        "class" : "category__rating"
                    },
					"children" : [
                        { "text" : "Child node 1",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 2",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 3",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 4",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 5",
                            "a_attr" : {
                                "class" : "category__rating"
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
				{
					"text" : "first root node",
                    "state" : { "opened" : true },
                    "a_attr" : {
                        "class" : "category__rating"
                    },
					"children" : [
                        { "text" : "Child node 1",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 2",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 3",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 4",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

                         { "text" : "Child node 5",
                            "a_attr" : {
                                "class" : "category__rating"
                            },
                         },

						{ "text" : "Child node 6"}
					]
                }
			]
		}
	});

    
});
