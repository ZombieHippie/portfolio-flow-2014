<?php ?>
<!DOCTYPE html>
<html>
<head>
    <title>Portfolio - Cole R Lawrence</title>
     <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href='http://fonts.googleapis.com/css?family=Lora:400,700|Oxygen:400,300|Roboto:100,300|Raleway:100,400' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="f/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="f/css/index.css">

    <script src="f/js/ICanHaz.min.js"></script>
</head>
<body>
    <div id="back" class="back-arrow animated" onclick="slide(null)"></div>
    <div id="super-canvas"><canvas id="page-canvas"></canvas></div>
    <div class="main-menu" style="font-size:18px">
        <div id="intro">
            <div>COLE R LAWRENCE</div>
        </div>
        <div id="tileNav">
            <script id="tile" type="text/html">
              <div class="tile {{color}}">
                <div class="t-dum"></div>
                <div class="t-content"
                style="color:#{{color}}">
                    {{name}}
                </div>
              </div>
            </script>
        </div>
        <div id="project-view-container">
            <div id="open-braces">
              <div class="brace-dum"></div>
              <div class="brace-cap left"></div>
              <div class="brace-cap right"></div>
            </div>
            <div id="project-view" class="read" style="display:none"></div>
        </div>
        <p><br></p>
        <script id="Category" type="text/html">
            <div id="{{id}}" class="category-view" style="">
                <div class="category-header">
                <div>{{name}}</div>
                </div>
                
            </div>
        </script>
        <div id="project-tiles">
          <script id="ProjectMin" type="text/html">
              <div class="tile project {{color}}" onclick="project('{{catname}}','{{projname}}', {{place}})">
                  <div class="t-dum"></div>
                  <div class="t-content min"
                  style="outline:solid #{{color}} 6px">
                      <img src="f/img/{{img}}" alt="{{name}}"></img>
                  </div>
              </div>
          </script>
        </div>
    </div>
    <script src="f/js/zepto.js"></script>
    <script>jQuery = Zepto</script>
    <script src="f/js/flowtype.js"></script>
    <script src="f/js/bigtext.js"></script>
<script>// shim layer with setTimeout fallback
  window.requestAnimFrame = (function(){
    return  window.requestAnimationFrame       ||
      window.webkitRequestAnimationFrame ||
      window.mozRequestAnimationFrame    ||
      function( callback ){
        window.setTimeout(callback, 1000 / 500);
      };
  })();</script>
<script src="f/coffee/Website.min.js"></script>
<script src="f/coffee/index.min.js"></script>
</body>
</html>