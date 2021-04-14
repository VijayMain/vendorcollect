<head>
 <script src="js/jquery.min.js"></script>
  <script src="js/raphael-min.js"></script>
  <script src="js/morris.js"></script>
  <script src="js/prettify.min.js"></script>
  <script src="lib/example.js"></script>
  <link rel="stylesheet" href="lib/example.css"/>
  <link rel="stylesheet" href="js/prettify.min.css"/>
  <link rel="stylesheet" href="js/morris.css"/>
</head>
<body>
<div style="width: 50%">
Datat logger 
</div>

<div style="width: 50%">
<h1>Formatting Dates with YYYY-MM</h1>
<div id="graph">
</div>

<pre id="code" class="prettyprint linenums" style="visibility: hidden;"> 
<%
int i=-87;
%>
var month_data = [
 
  {"period": "1", "licensed": <%=i %>},
  {"period": "2", "licensed": 888},
  {"period": "3", "licensed": 334 },
  {"period": "4", "licensed": 234},
  {"period": "5", "licensed": 344},
  {"period": "6", "licensed": 328},
  {"period": "7", "licensed": 949},
  {"period": "8", "licensed": 371},
  {"period": "9", "licensed": 659},
  {"period": "10", "licensed": -89} 

];


Morris.Line({
  element: 'graph',
  data: month_data,
  xkey: 'period',
  ykeys: ['licensed', ''],
  labels: ['licensed', ''],
  smooth: true
});
</pre>

</div>
</body>
