g = exports ? this
g.say = (o) =>
  console.log o
g.project = (catname, projname, place) =>
  say catname
  say projname
  scrollToHere = 0
  movedRows = true
  !( ->

    tileWidth = $(".main-menu>.tile").eq(0).width()
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
    scrollToHere = $(".tile.project").eq(placeAfter-1).after($("#project-view-container")).offset().top
  )()
  ###
  ###
  tile = $(".tile.project").eq(place)
  $('#project-view-container').css {height:0}
  if movedRows
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
  v = $('#project-view')
  v.html ""
  v.show()
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
      when "img" then v.append "<img src=\"projects/#{proj.slug}/#{val}\"/>"
      when "logo" then v.append "<img class=\"logo\" src=\"projects/#{proj.slug}/#{val}\"/>"
  $("#project-view").flowtype({
   fontRatio : 30
   lineRatio : 1.45
  })

  smoothScroll $("html"), scrollToHere, 100
  $("#project-view-container").removeClass "open"
  window.setTimeout(()->
    $('#project-view-container').animate {height:$('#project-view').height()+100}, {
      duration: 1200
      easing: 'easein'
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
}`
get_a_color= () =>
  letters = 'db97'.split('');
  color = '#';
  for i in [1..3]
    color += letters[Math.round(Math.random() * 3)]
  color
WebsiteColors = 
  "INTERACTIVE MEDIA":"33CBDB"
  "ANIMATION":"DB3333"
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
      $('.main-menu').append ich.ProjectMin({
        projname:projname
        catname:catname
        img:projinfo.img
        place:place++
        color:WebsiteColors[catname]
      })
  $('#about').appendTo('.main-menu')
  Zepto.getScript = (url, success, error) ->
    script = document.createElement("script")
    $script = $(script)
    script.src = url
    $("head").append(script)
    $script.bind("load", success)
    $script.bind("error", error)
  $(window).resize()