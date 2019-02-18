$( document ).ready(function() {

    var $tonalityPopup = $('.tonality-popup');
    var filtersBtn = $('.filters-panel__btn');
    var filtersPanel = $('.filters-panel');

    filtersPanel.hasClass('active') ? $('#wrapper').addClass('panel-open-mb') : $('#wrapper').removeClass('panel-open-mb');

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

    $('.open-jstree').on('click', function(e) {
        $('#popup').addClass('show');
    })

    $('#popup').find('.close').on('click', function(e) {
        $('#popup').removeClass('show')
    })

    filtersBtn.on('click', function() {
        if (filtersPanel.hasClass('active') ) {
            filtersPanel.removeClass('active');
            $('#wrapper').removeClass('panel-open-mb')
        } else {
            filtersPanel.addClass('active');
            $('#wrapper').addClass('panel-open-mb');
        }

    });

    $('.datepicker').on('click', function (e) {
        var target = $(e.target);
        if (target.hasClass('range__item') && target.index() !== target.parent().children().length - 1) {
            return true;
        } else {
            return false
        }
    });

    $('.period').each(function() {
        $(this).find('li').each(function(i) {
            $(this).click(function(){
                console.log($(this).index())
                if ($(this).index() === 0) {
                    $(this).addClass('period__item--active').siblings().removeClass('period__item--active')
                    .closest('.datepicker').find('.calendar').removeClass('active')
                } else {
                    $(this).addClass('period__item--active').siblings().removeClass('period__item--active')
                    .closest('.datepicker').find('.calendar').removeClass('active').eq(i - 1).addClass('active');
                }
            });
        });
    });

    
    $( "#slider-range" ).slider({
        range: true,
        min: 0,
        max: 100000,
        values: [ 0, 100000 ],
        step: 500,
        slide: function( event, ui ) {
          $( "#amount1" ).val(ui.values[ 0 ] );
          $( "#amount2" ).val(ui.values[ 1 ] );
        }
      });
      $( "#amount1" ).val($( "#slider-range" ).slider( "values", 0 ));
      $( "#amount2" ).val($( "#slider-range" ).slider( "values", 1 ));


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
