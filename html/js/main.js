$( document ).ready(function() {

    var $tonalityPopup = $('.tonality-popup');
    var filtersBtn = $('.filters-panel__btn');
    var filtersPanel = $('.filters-panel');

    // category popup

    $('.category__value').find('a').on('click', function(e) {
        e.preventDefault();
        var $item = $(this).closest('.category__item');
        var $popupHeading = $item.find('.category__name').text();
        var $tonalityPopup = $(this).closest('.category__item').find('.tonality-popup');
        $tonalityPopup.toggleClass('show');
        $tonalityPopup.find('.tonality-popup__header').text($popupHeading)
    });

   $('.addPanel').on('click', function(e) {
    $( ".spacing__panel" ).append( '<div class="panel">panel</div>' );
   })

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

    // Filters panel
    // filtersPanel.hasClass('active') ? $('#wrapper').addClass('panel-open-mb') : $('#wrapper').removeClass('panel-open-mb');

    // filtersBtn.on('click', function() {
    //     if (filtersPanel.hasClass('active') ) {
    //         filtersPanel.removeClass('active');
    //         $('#wrapper').removeClass('panel-open-mb')
    //     } else {
    //         filtersPanel.addClass('active');
    //         $('#wrapper').addClass('panel-open-mb');
    //     }

    // });

    // MESSAGE HISTORY

    $('.message-item__history .close').on('click', function(e) {
        e.preventDefault()
        $(this).parent().slideUp(500);
    })

    $('.link-history').on('click', function(e) {
        e.preventDefault()
        $(this).closest('.message-item').find('.message-item__history').slideToggle(500);
    })

    // DATEPICKER

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

    

    // SLIDER

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



    // below this line part for resizing container

    var reflexContainer = $('.reflex-container'),
        reflexElementLeft = reflexContainer.find('> .reflex-element--left'),
        reflexElementRight = reflexContainer.find('> .reflex-element--right')
        handle = reflexContainer.find('> .vertical-divider')
        ;

    if (reflexElementLeft.length && reflexElementRight.length) {
        var leftFlex = Number( reflexElementLeft.css('flex-grow').replace(/ .*/,''));
        var rightFlex = Number( reflexElementRight.css('flex-grow').replace(/ .*/,''));
    }
    isResizing = false
    handle.on('mousedown', function (e) {
        lastDownX = e.clientX;
        isResizing = true

        reflexContainer.addClass('active')

        $(document).on('mousemove', function (e) {

            if (!isResizing) return
            totalFlex = rightFlex + leftFlex; // get total flex
            var onePX = 1 / (reflexContainer.width() / totalFlex); //calculate size of 1px for 1 flex-grow
            var offsetRight = (e.clientX - reflexContainer.offset().left); // subtract from the position of the cursor left indent of the container

            leftFlex =  offsetRight * onePX;  
            rightFlex =  reflexContainer.width() * onePX - leftFlex;
            reflexElementLeft.css('flex', ((leftFlex)) + ' 1 0%');
            reflexElementRight.css('flex', ((rightFlex)) + ' 1 0%');
    
        }).on('mouseup', function (e) {
            // stop resizing
            isResizing = false;
            $(document).off( "mousemove");
            reflexContainer.removeClass('active')
        });
    });


    // ressource

    // $('.table-tree__condition').on('click', function(e) {
    //     $(this).parent().toggleClass('tree-collapse');
    //     $(this).parent().next().slideToggle(400)
    // })

    // $('.table-tree__btn:nth-child(2)').on('click', function(e) {
    //     var item = $(this).closest('.table-tree__item');
    //     item .addClass('active').find('.table-tree__name').attr( 'contenteditable', 'true' ).focus();
    // })

    $('#collapseAll').on('click', function(e) {
        var parentItems = $('.table-tree').find('.table-tree__item.have-children');
        parentItems.each(function(e) {
            if (!$(this).hasClass('tree-collapse')) {
                $(this).addClass('tree-collapse')
                .next().slideToggle(400)
            }
        })
    })

    $('#expandAll').on('click', function(e) {
        var parentItems = $('.table-tree').find('.table-tree__item.have-children');
        parentItems.each(function(e) {
            if ($(this).hasClass('tree-collapse')) {
                $(this).removeClass('tree-collapse')
                .next().slideToggle(400)
            }
        })
        
    })

    $('.ressource-list__item').find('.ressource-list__btn:nth-of-type(1)').on('click', function(e) {
        var name = $(this).prev();
        $(this).toggleClass('active');
        if (name.attr( 'contenteditable' )) {
            name.removeAttr( 'contenteditable', 'false' )
        } else {
            name.prop( 'contenteditable', 'true').focus();
        }
    })

    $('.root span').on('click', function(e) {
        $(this).parent().toggleClass('open')
    })
    
    // DON'T COPY CODE BELOW THIS LINE (THIS FOR LOCAL JSTREE)

    $('#jsTreeCategory').on('changed.jstree', function (e, data) {
        $(this).find(".jstree-anchor").append('<a class="link-icon" href="#"><span><i class="icon-plus-sign-alt"></i></span> Add category</a>');
    })


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

    $('#jsTreeCategory1').jstree({
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

                         { "text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
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

var arr = [{
    key: 'search_and_filter',
    text: 'search sda& filter'
},{
    key: 'extended_text_search',
    text: 'extendeddas text search'
},{
    key: 'category_filter',
    text: 'category dasfilter'
}]


document.addEventListener("DOMContentLoaded", function(e) {
    let translateText = document.querySelectorAll('.text-translate');
    //console.log(translateText)
    translateText.forEach(function(e) {
        let dataTr = e.getAttribute('data-translate');
        arr.forEach(function(tr) {
            if ( tr.key === dataTr ) {
                e.textContent = tr.text;
                return
            }
        })
    })
});