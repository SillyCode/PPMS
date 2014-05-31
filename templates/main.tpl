<html>
<head>

<!-- TODO: Make the events general and global -->
<!-- TODO: Seperate the timeline drawing to an own function -->
<!-- TODO: Implement "Add event" function -->
<!-- TODO: Implement "add/remove group -->
<!-- TODO: Create a task "class" file -->
<!-- TASK: Figure out how to set permanent margin on the left axis -->
<!-- TODO: Add note to the task creation about mandatory fields -->
<!-- TODO: Add tooltips to the fields in task creation -->
<!-- TODO: Add server validation to task -->
<!-- TODO: Apply the same styling to the task creation form as the timeline -->
<!-- TODO: Implement function remove even when the task is deleted through UI
-->
<!-- TODO: generate unique id for each new task -->

	<script type="text/javascript" src="timeline/timeline.js"></script>
	<script type="text/javascript" stc="assets/js/timeline.js"></script>
	<link rel="stylesheet" type="text/css" href="timeline/timeline.css">
	<link rel="stylesheet" type="text/css" href="assets/css/timeline.css">
	<script>
		var data = []; //
		var events = {}; //tasks
		var timeline;
		var options; //global options
		function create_events() {

			//DEBUG:
			var event = {
				'id':1,
				'start': new Date(2012,7,15),
				'end': new Date(2012,07,19),
				'group': 'A',
				'content': 'Project A'
				};

			//DEBUG:
			var event_1 = {
				'id':2,
				'start': new Date(2012,7,20),
				'end': new Date(2012,07,22),
				'group': 'B',
				'content': 'Project B'
				};

			insert_new_event(event);
			insert_new_event(event_1);

			redraw_timeline(data);
		}

		function get_event_id(event) {
			return event.id;
		}

		//creates new event
		function new_event () {
			document.getElementById("timeline").style.display = "none";
// 			document.getElementById("group_add").style.display = "none";
			document.getElementById("create_event").style.display = "block";

			//DEBUG:
			var eve = {
				'id':3,
				'start': new Date(2012,7,20),
				'end': new Date(2012,07,27),
				'group': 'B',
				'content': 'Project C'
			};
// 			insert_new_event(eve);
		}

		//adding/removing group
		function add_remove_group () {
			alert("In progress");
		}

		//inserts new event into `events` and `data`
		function insert_new_event(event) {
			if(events[event.id] == undefined) {
				events[event.id] = event;
			}
			data.push(event);
		}

		//re-initialize `data` object
		function refill_data() {
			data = [];
			for(var i in events) {
				data.push(events[i]);
			}
		}

		function redraw_timeline(data) {
			options = { //global settings
				'start': new Date(2012,1,1),
				'axisOnTop': 'true',
				'width':  '100%',
				'height': 'auto',
				'style': 'range',
				'showButtonNew': true, //Added the new button at far left end
				'groupChangeable': true, //Allows to move events between groupd members
				'editable': true //Allows to edit the events
			};

			timeline = new links.Timeline(document.getElementById('timeline'), options);
			timeline.draw(data);

			links.events.addListener(timeline, 'add', new_event);
		}

		//returns to the timeline
		function get_back() {
			document.getElementById("timeline").style.display = "block";
// 			document.getElementById("group_add").style.display = "block";
			document.getElementById("create_event").style.display = "none";
			timeline.draw(data);
		}

	</script>
</head>
<body onload="create_events()">
  <div id="timeline"></div>
<!-- TEST -->
<!--   <div id="group_add"><a class="new_event" value="Add event" onclick="add_group()">Add</a></div> -->
  <div id="create_event" style="display:none">
	<form method="POST">
	  <table>
		  <tr><th colspan="2" class="th_new_event">Create New Task</th></tr>
		  <tr><td>Task Name*</td><td><input type="text" name="task_name"
/></td></tr>
		  <tr><td>Starting Time (d/m/y)*</td><td><input type="text" name="task_start" /></td></tr>
		  <tr><td>Ending Time (d/m/y)</td><td><input type="text" name="task_end"
/></td></tr>
		  <tr><td>Content*</td><td><input type="text" name="task_content"
/></td></tr>
		  <tr><td>Group</td><td><input type="text" name="task_group"
/></td></tr>
	  <tr><td><input type="submit" value="Apply" /></td><td><input
type="button" value="Back" onclick="get_back()" /></td></tr>
	  </table>
	</form>
	<div class="note">Fields marked with * are mandatory</div>
  </div>
</body>
</html>
