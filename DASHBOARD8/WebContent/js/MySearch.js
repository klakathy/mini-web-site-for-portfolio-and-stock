$.extend({
    myMethod: function (id,tagData,name) {  
    	var html  =  '<div class="layui-form-item">';
            html +=		 '<div class="AD" style="margin-left:0px;">';
            html +=		 '</div>';
            html +=      '<div class="Proportion"></div>'
			html +=	 '</div>';
			html +=	 '<div class="layui-form-item">'; 
			html +=				'<p style="color:white;font-weight:500;font-size:30px;" class="WH">Stocks Selection</p>';
			html +=	     '<div class="layui-input-inline fileId layui-form-select layui-form-selected">';
			html +=			'<input type="text" class="layui-input" placeholder="input or choose" autocomplete="off">';
			html +=		   	'<dl style="display: none;">Your choices</dl>';
			html +=		 '</div>';
			html +=	 '</div>';
    	$(id).append(html)
        $(".AD").parent().hide();
    
	    $(".fileId").on("click","dl dd",function(){
	    	var id = $(this).attr("value");
	    	if(id!=undefined){
	    		$(".AD").append('<a href="javascript:;" style="width:200px;height:29px;float:none;"class="label"><span lay-value="64">'+$(this).html()+'</span><input type="hidden" name="'+name+'" id="'+$(this).html()+'" value="'+id+'"/><i class="layui-icon close">x</i>'+   '<input type="text" id="V'+$(this).html()+'" style="width:50px;float:right;margin-right:62px;"value="10">'     +'</a>')
                $(".AD").parent().show();
       
	    		for(var i=0;i<tagData.length;i++){
	    			if(tagData[i].id == id){
	    				tagData.splice(i,1);
	    			}
	    		}
	    	}
	    	$(".fileId dl").hide();
	    	$(".fileId input").val("");
        

            
        })
		
		function AD(name,id){
            this.name=name;
            this.id=id;
        }
	    
	 	//删除当前广告
		$(".AD").on("click",".close",function(){
			$(this).parent().remove();
			var id = $(this).parent().children("input").val();
			var text = $(this).parent().children("input").attr("id");
			tagData.push(new AD(text,id))
		})
        
        
        
		//筛选
	    $(".fileId input").on("input propertychange",function(){
	    	$(".fileId dl dd").remove();
	    	$(".fileId dl").hide();
    		if(tagData.length>0){
    			$(".fileId dl").show();    		
    			var sear = new RegExp($(this).val())
    			var temp=0;
	    		for(var i=0;i<tagData.length;i++){
	    			if(sear.test(tagData[i].name)){
	    				temp++
		    			$(".fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
	    			}
	    		}
	    		if(temp==0){
	    			$(".fileId dl").append('<dd>No data</dd>')
	    		}
    		}
	   	})	
	   	
	   	//隐藏
	   	$(document).click(function(){
			$(".fileId dl").hide();
	    	$(".fileId input").val("");
		});
	 	
	 	//显示没被选择的
		$(".fileId input").click(function(event){
			$(".fileId dl dd").remove();
	    	if(tagData.length==0){
				$(this).val("No data")
	    	}else{
		    	$(".fileId dl").show()
	    	}
	    	for(var i=0;i<tagData.length;i++){
	    		$(".fileId dl").append('<dd value="'+tagData[i].id+'">'+tagData[i].name+'</dd>')
    		}
			event.stopPropagation();
		});
    }
});