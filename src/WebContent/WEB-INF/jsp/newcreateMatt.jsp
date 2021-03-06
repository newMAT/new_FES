<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="d" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="generator" content="CoffeeCup Web Editor (www.coffeecup.com)">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <title>Save</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <link rel="stylesheet" type="text/css" href="resources/newstylemat.css" />
    <script src="//code.jquery.com/jquery-1.10.2.js"></script> 
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
  <script>
  $(document).ready(init);
  $( "#mattTable1 > *").click( function () {
	  	var arg=$(this).attr("id");
	  	var arr=document.getElementById("par1").value;
	  	var json = JSON.parse(arr);
	      var i = arg.slice(2,4);
	      i=i.replace ( /[^\d.]/g, '' );	
	      var j = arg.slice(4);
	      j=j.replace ( /[^\d.]/g, '' );	   	                
	      var cell = document.getElementById(arg);
	      if(cell.style.backgroundColor == "rgb(240, 240, 240)")
	      {
	          cell.style.backgroundColor = "green";	      			
	          		json[4][i][j]=0;
	          		document.getElementById("par1").value=JSON.stringify(json);
	      }
	      else {
	          cell.style.backgroundColor = "rgb(240, 240, 240)";	        	
	          		json[4][i][j]=1;
	          		document.getElementById("par1").value=JSON.stringify(json);
	      }  
	  });
  $('td').click();
  function init(){
  $(function() {
    $( "#mattTable1" ).selectable({
    	distance:10,
    	stop: function() {
        $( "td.ui-selected", this ).each(function() {
        	$( this ).click();
        });
      }
    });
  });
  };
</script>

<script type="text/javascript">
function save(){
	var json=document.getElementById("par1").value;
	var data ="mattjson="+json;
	$.ajax({
		url : "ajaxjson",
		data : data,
		type : "POST",
		complete : function() {
			document.getElementById("myform").action="saveMatt";
			document.forms["myform"].submit();
		}
	});
	}
</script>
<script type="text/javascript">
function upload(){
	var json=document.getElementById("par1").value;
	var data ="mattjson="+json;
	$.ajax({
		url : "ajaxjson",
		data : data,
		type : "POST",
		complete : function() {
			document.getElementById("myform").action="upload_matt";
			document.forms["myform"].submit();
		}
	});
	}
</script>
    <script>
    function viewTab(s1){
    	var s=s1;
		var arr=document.getElementById("par1").value;
        var json = JSON.parse(arr);

        var oldTable = document.getElementById('mattTable'),
                newTable = oldTable.cloneNode();
        var tr = document.createElement('tr');
        tr.id = "dayValue";
        var th=document.createElement('th');
        for(var i = s; i < json[2].length && i<s+7; i++){
            var th = document.createElement('th');
            th.appendChild(document.createTextNode(json[2][i]));
            tr.appendChild(th);
        }
        newTable.appendChild(tr);
      
        var tr1 = document.createElement('tr');
        for(var i = s; i < json[1].length && i<s+7; i++){
            var th1 = document.createElement('td');
            var id = "th" + i;
            th1.id = id;
            th1.appendChild(document.createTextNode(json[1][i]));
            tr1.appendChild(th1);
        }
	       newTable.appendChild(tr1);
	      oldTable.parentNode.replaceChild(newTable, oldTable);
	      
	      var oldTable = document.getElementById('mattTable1'),
    	 newTable = oldTable.cloneNode();
	      
        for(var i = 0; i < json[3].length; i++){
            var tr = document.createElement('tr');
            for(var j = s; j < json[2].length && j<s+7; j++){
                var td = document.createElement('td');
                var id = "td" + i+"s" + j;
                td.id = id;
                td.appendChild(document.createTextNode(json[3][i]));
                if(json[4][i][j]==0) {
                    td.style.backgroundColor = "green";
                    td.setAttribute("onClick", "changeColor(id)");
                    td.style.cursor = "pointer";
                }
                if(json[4][i][j]==2) {
                    td.style.backgroundColor = "yellow";
                    td.setAttribute("onClick", "changeColor(id)");
                    td.style.cursor = "pointer";
                }
                if(json[4][i][j]==1) {
                    td.style.backgroundColor = "#f0f0f0";
                    td.setAttribute("onClick", "changeColor(id)");
                    td.style.cursor = "pointer";
                }
                
                tr.appendChild(td);
            }
            newTable.appendChild(tr);
        }
        oldTable.parentNode.replaceChild(newTable, oldTable);

    }
    </script>
    <script>  
    function mback(){
  	  var x=document.getElementById("wek").value;	 
	  x--;
	  document.getElementById("wek").value=x;
	  if(x==0)document.getElementById("back").disabled=true;	
		var json=document.getElementById("par1").value;
		var data ="mattjson="+json+"&plus="+"minus";
		$.ajax({
			url : "newJson",
			data : data,
			type : "GET",
			success : function(mattToJSON) {
				document.getElementById("par1").value=mattToJSON;
				viewTab(0);
				 $(document).ready(init);
			}
		});	

    }
</script>
<script>
  function mnext(){
	  var x=document.getElementById("wek").value;	 
	  x++;
	  document.getElementById("wek").value=x;
	  document.getElementById("back").disabled=false;	
		var json=document.getElementById("par1").value;
		var data ="mattjson="+json+"&plus="+"plus";
		$.ajax({
			url : "newJson",
			data : data,
			type : "GET",
			success : function(mattToJSON) {
				document.getElementById("par1").value=mattToJSON;
				viewTab(0);
				 $(document).ready(init);
			}
		});	

    }
  </script>

  <script type="text/javascript">  
  function changeColor(arg) {
  	var arr = document.getElementById("par1").value;
  	var json = JSON.parse(arr);
      var i = arg.slice(2,4);
      i=i.replace ( /[^\d.]/g, '' );	
      var j = arg.slice(4);
      j=j.replace ( /[^\d.]/g, '' );	   	                
      var cell = document.getElementById(arg);
      if(cell.style.backgroundColor == "rgb(240, 240, 240)")
      {
          cell.style.backgroundColor = "green";	
          		json[4][i][j]=0;
          		document.getElementById("par1").value=JSON.stringify(json);
      }
      else {
          cell.style.backgroundColor = "rgb(240, 240, 240)"; 		
          		json[4][i][j]=1;
          		document.getElementById("par1").value=JSON.stringify(json);
      }  
  }
  </script>

  <script>
  function myFunction() {
	    var elmnt = document.getElementById("art");
	    elmnt.scrollTop = 0;
}
  </script>
		<script type="text/javascript">
			function sharefn(state){
				$('#wrap1').show(0);
					document.getElementById('share1').style.display = state;			
					document.getElementById('wrap1').style.display = state; 			
			}		
			function repeatfn(state){
				$('#wrap1').show(0);
					document.getElementById('repeat1').style.display = state;			
					document.getElementById('wrap1').style.display = state; 			
			}		
		</script>
</head>
<body onload="myFunction()">
	<div onclick="sharefn('none')" id="wrap1"></div>

	<div id="share1">
	<form action="newmatt">
			<input type="button" value="X" onclick="sharefn('none')" /><br>
			<a  id="googleshare" href="https://plus.google.com/share?url=http://ec2-54-166-51-117.compute-1.amazonaws.com:8080/myavailabletime/viewMatt%3Ftable%3D${idmat}%26username%3D${userName}" 
                onclick=" sharegoogle(); javascript:window.open(this.href, '', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;"><br>
                <img src="https://www.gstatic.com/images/icons/gplus-32.png" title="Share on Google+" width='30' height='30'/></a><br>
			
			 <input id="2" type="submit" value="NEXT" />			
	</form>
	</div>
	
	<div id="repeat1">
	<form >
			<input type="button" value="X" onclick="repeatfn('none')" /><br>

			<p>Repeat week<input type="radio">
			<select id="repweek" >
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
					<option value="32">32</option>
					<option value="33">33</option>
					<option value="34">34</option>
					<option value="35">35</option>
					<option value="36">36</option>
					<option value="37">37</option>
					<option value="38">38</option>
					<option value="39">39</option>
					<option value="40">40</option>
					<option value="41">41</option>
					<option value="42">42</option>
					<option value="43">43</option>
					<option value="44">44</option>
					<option value="45">45</option>
					<option value="46">46</option>
					<option value="47">47</option>
					<option value="48">48</option>
					<option value="49">49</option>
					<option value="50">50</option>
					<option value="51">51</option>
					<option value="52">52</option>					
			</select><br>
			</p>
			<p>Repeat month<input type="radio"  >
			<select id="repmon" >
					<option value="53">1</option>
					<option value="54">2</option>
					<option value="55">3</option>
					<option value="56">4</option>
					<option value="57">5</option>
					<option value="58">6</option>
					<option value="59">7</option>
					<option value="60">8</option>
					<option value="61">9</option>
					<option value="62">10</option>
					<option value="63">11</option>
					<option value="64">12</option>				
			</select><br>
			</p>
		
			<br><input value="NEXT" onclick="repeatajax(),repeatfn('none')" />			
	</form>
	</div>
	
<div class="header">
<form id="log" >
    <span><a class="logo">Logged in as: ${userName}</a></span>
    <span class="topmenu" style="float:right;"> Logout</span>
    <span class="topmenu" style="float:right;"> <button type="submit" style="color: white;" onclick="log.action='accountsettings'">Account settings</button></span> 
</form>
</div>
<div id="wrapper">
    <p style="font-size: 1em ">${namecalendar}'s Calendar</p>
    <form id=myform>
    <div id="first">
        <div class="left">
        <input name="home" type="image" src="resources/img/home.png" title="home" onclick="myform.action='homereturn'" width='50' height='50'><br>
       	<input name="edit" type="image" src="resources/img/edit.png" title="edit" onclick="myform.action='action_edit'" width='50' height='50'><br>
        <img name="share" src="resources/img/share.png" title="share" onclick="sharefn('block')" width='50' height='50' /><br>
       	<input name="collaborate" type="image" src="resources/img/collaborate.png" title="collaborate" onclick="table.value=this.name, tableForm.action='viewMatt'" width='50' height='50'><br>
       	<input name="upload" type="image" src="resources/img/upload.png" title="upload" onclick="upload()" width='50' height='50'><br>
       	<input name="download" type="image" src="resources/img/download.png" title="download" onclick="table.value=this.name, tableForm.action='viewMatt'" width='50' height='50'><br>
        <img name="share" src="resources/img/repeat.png" title="repeat" onclick="repeatfn('block')" width='50' height='50' /><br>

       	 <button id="saveMatt" type="button" onclick="save()" >SAVE</button>  	
		</div>
    </div>

	<input type="hidden" id="table" name="table">

	</form>
	<form id="blok-form" name="blok-form">
    <div id="second">
        <div class="right">
        
            <button id="back" type="button" disabled onclick="mback()">back</button>
            <button id="next" type="button" onclick="mnext()">next</button>
        </div>
        <div  >
 			  <input id="par1" name="mattToJSON" value='${matJSON}' size="150" />
              <input id="txtback" name="txtback" value=0 type="hidden"/>
 			  <input id="txtnext" name="txtnext" value=0 type="hidden"/>
 			  <input id="wek" name="wek" value=0 type="hidden"/>
 			<div>
            <table id="mattTable"  >
            </table>
            </div>
            <div id="art" style="overflow:scroll; height:300px; width:100% ">
            <table id="mattTable1"  >
            </table>
            </div>
            <script>
            viewTab(0);
            </script>
        </div>
    </div>
    </form>


</div>
</body>
</html>