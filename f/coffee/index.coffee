g = exports ? this
g.say = (o) =>
  console.log o
g.project = (catname, projname, place) =>
  say catname
  say projname
  scrollToHere = 0
  movedRows = true
  !( ->

    tileWidth = $("#project-tiles>.tile").eq(0).width()
    tilesH = $(".main-menu").width() / tileWidth
    tilesH = Math.round tilesH
    placeAfter = (tilesH + place) - ( place % tilesH )
    say "pos "+ (place % tilesH) + "  place "+place+"  tilesH "+tilesH+"  after "+placeAfter
    movedRows = not $("#open-braces").hasClass "pA-"+placeAfter
    $("#open-braces").removeClass()
    $("#open-braces").addClass "pA-"+placeAfter
    $("#open-braces").css {
      "background-position": (tileWidth/2 + tileWidth*(place % tilesH)) + "px 0"
      "background-color": '#'+WebsiteColors[catname]
    }
    $(".brace-cap").css "background-color": '#'+WebsiteColors[catname]
    ###
    ###
    placeAfter = $(".tile.project").eq(placeAfter-1)
    if placeAfter.length is 0
      placeAfter = $(".tile.project").eq(-1)
    scrollToHere = placeAfter.after($("#project-view-container")).offset().top
  )()
  ###
  ###
  tile = $(".tile.project").eq(place)
  $('#project-view').hide()
  $("#project-view-container").removeClass "open"
  ###
  ###
  if tile.hasClass "active-tile"
    # Close open project
    tile.removeClass "active-tile"
    return
  else
    $(".active-tile").removeClass("active-tile")
    tile.addClass "active-tile"

  proj = Website[catname][projname]
  v = $('#content')
  v.html ""
  $('#project-view').show()
  for item, val of proj.items
    item = item.split('-')[0]
    switch item
      when "p" then v.append "<p>#{val}</p>"
      when "x" then v.append "#{val}"
      when "gh" then v.append "<i><a href=\"http://github.com/#{val}\">#{val}</a> on GitHub</i>"
      when "yt" then v.append "<iframe width=\"100%\" height=\"#{(v.width() / 1.5)}px\" src=\"http://youtube.com/embed/#{val}\" frameborder=\"0\" allowfullscreen></iframe>"
      when "if" then v.append "<iframe width=\"100%\" height=\"#{v.width() / 1.5}px\" src=\"#{val}\" frameborder=\"0\" allowfullscreen></iframe>"
      when "swf"
        v.append """<embed src="projects/#{proj.slug}/#{val}.swf" width="#{v.width()}" height="#{v.width() / 1.33333}" base="." 
            type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />"""
      when "img" then v.append "<div class='imgc'><div class='img-dum'></div><img src=\"projects/#{proj.slug}/#{val}\"/></div>"
      when "logo" then v.append "<img class=\"logo\" src=\"projects/#{proj.slug}/#{val}\"/>"
  window.setTimeout(()->
    $('#project-view').show()
    $(".read").flowtype fontRatio : 30, lineRatio : 1.45

    smoothScroll2 scrollToHere, 400
    $('#project-view-container').animate {height:$('#project-view').height()+100}, {
      duration: 1200
      ease: 'easeOutCubic'
      complete: ()->
        say "Now open #{projname}"
        $('#project-view-container').css {height:""}
        $("#project-view-container").addClass "open"
    }
  , 500)
`function smoothScroll(el, to, duration) {
    if (duration < 0) {
        return;
    }
    var difference = to - $(window).scrollTop();
    var perTick = difference / duration * 10;
    this.scrollToTimerCache = setTimeout(function() {
        if (!isNaN(parseInt(perTick, 10))) {
            window.scrollTo(0, $(window).scrollTop() + perTick);
            smoothScroll(el, to, duration - 10);
        }
    }.bind(this), 10);
}function smoothScroll2(to, duration) {
    if (duration < 0) {
        return;
    }
    var difference = to - window.scrollY;
    var perTick = difference / duration * 10;
    this.scrollToTimerCache = setTimeout(function() {
        if (!isNaN(parseInt(perTick, 10))) {
            window.scrollTo(0, window.scrollY + perTick);
            smoothScroll2(to, duration - 10);
        }
    }.bind(this), 10);
}function getWindowRelativeOffset(parentWindow, elem) {
        var offset = {
            left : 0,
            top : 0
        };
        // relative to the target field's document
        offset.left = elem.getBoundingClientRect().left;
        offset.top = elem.getBoundingClientRect().top;
        // now we will calculate according to the current document, this current
        // document might be same as the document of target field or it may be
        // parent of the document of the target field
        var childWindow = elem.document.frames.window;
        while (childWindow != parentWindow) {
            offset.left = offset.left + childWindow.frameElement.getBoundingClientRect().left;
            offset.top = offset.top + childWindow.frameElement.getBoundingClientRect().top;
            childWindow = childWindow.parent;
        }

        return offset;
    };
`
get_a_color= () =>
  letters = 'db97'.split('');
  color = '#';
  for i in [1..3]
    color += letters[Math.round(Math.random() * 3)]
  color
WebsiteColors = 
  "ANIMATION MODELING":"33CBDB"
  "INTERACTIVE MEDIA":"DB3333"
  "GRAPHIC DESIGN":"910062"
  "TRADITIONAL ART":"5A3662"
###
    "FRC Robotics Ascention Code":
      img:"ascention.png"
      slug:"ascention"
      items:
        "p-1":"<h1>FRC Ascention Robot - Java Code</h1>"
        "p-2":"Although only a boilerplate for our robot, this code repository poses as a good demonstration of my knowledge of Java and my advanced coding practices: informative comments, clear variable identifiers, and good organization."
        "gh-1":"ZombieHippie/VikingsRobot2013"###

$("#intro").bigtext()
evaluateHashUrl= ->
    hrefM = window.location.href.split('#')[1]
    if hrefM?
      $("a[href='#"+hrefM+"']").parent().parent().click()
$(window).on "load", (e) ->
  $("#intro").bigtext()
  place = 0
  for catname, catinfo of Website
    $("#tileNav").append ich.tile({
      color:WebsiteColors[catname], name:catname, arg:catname
    })
    catid = catname.replace(/\s+/g, '')
    ###
    $('.main-menu').append ich.Category({
      name:catname
      id:catid
    })
    ###
    for projname, projinfo of catinfo
      $('#project-tiles').append ich.ProjectMin({
        projname:projname
        catname:catname
        img:projinfo.img
        place:place++
        color:WebsiteColors[catname]
      })
  evaluateHashUrl()
  $(window).on 'hashchange', ->
    evaluateHashUrl()
  if Zepto?
    Zepto.getScript = (url, success, error) ->
      script = document.createElement("script")
      $script = $(script)
      script.src = url
      $("head").append(script)
      $script.bind("load", success)
      $script.bind("error", error)
  $(window).resize()