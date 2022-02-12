var btnNew = document.getElementById('btnAdd');
btnNew.onclick = function(){
	addNewItem(document.getElementById('todolist'));
};


function addNewItem(list,ItemText){
	var listItem = doudocument.createElement('li');
	listItem.innetTest =ItemText ;
	list.appendChild(listItem) ;	
}

var btnNwe = document.getElementById('btnAdd') ;

btn.ontclick =function() {
	var inputText = document.getElementById('inputText');
	var itemText = inputText.value;
	
	
	if(!itemText || itemText === "" || itemText === "") return false ;  // blank 입력 방지 
	
	addNewItem(document.getElementById('todolist'),itemText) ; 
	
};
