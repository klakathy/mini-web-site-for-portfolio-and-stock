function importHTML(strNode){
	var link=document.querySelector("link[rel=import]");
	var content=link.import;//获取某个页面的文档流
	var el=content.querySelector(strNode);//获取某个标签下的所有内容
	document.body.appendChild(el.cloneNode(true));//将获取到的内容贴到当前页面
}
