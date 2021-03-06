var margin = {top: 0, right: 100, bottom: 100, left: 100},
    width = 960 - margin.left - margin.right,
    height = 900 - margin.top - margin.bottom;

var x = d3.scale.linear()
    .domain([0, 100])
    .nice()
    .range([0, width]);

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

svg.append("g")
    .attr("class", "x axis")
    .call(d3.svg.axis().scale(x).orient("bottom"));
