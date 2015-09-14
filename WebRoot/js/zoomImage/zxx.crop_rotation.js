//ͼƬ��ת
// zxx.crop_rotation.js by zhangxinxu  welcome to visit my personal website http://www.zhangxinxu.com/
// 2010-05-06 v1.0 beta
// 2010-05-07 v1.1 �ü���box�߶�����canvas�߶����Ӷ�����
// ͼƬ������תǰ��չʾ
/*һЩ˵��:
* 1. ��תЧ���鿴��ͨ���ڽǶ��ı�����������ֵ
* 2. ��̨����ͼƬ��Ҫ5��������������ʼ�㣬�Լ����õĸ߿���5������������ͨ��id��ȡ�����нǶ�ֵ����ת�Ƕ�������ֵ��idΪzxxRotAngle�����꼰�߿�����ֱ����4�����ص��ı����У�id�ֱ��ǣ�cropPosX, cropPosY, cropImageWidth, cropImageHeight
* 3. �Զ��Աȵ�ǰͼƬ��ԭʼͼƬ�ߴ����������ʵ�ʵļ���ֵ�����ڸ߶ȼ�λ�����Ҳ���˴���
* 4. �����������ͼƬ��ת�������ڵ������������ڵ�Ԫ�ص�position����Ϊrelative��z-indexΪ1�����޸�������
* 5. ���Ҳ��ԣ�excanvas.js����ͷ��������֧��IE�������canvas
*/
var fnImageCropRot = function(o){
	//oΪͼƬ����
	if(typeof(o) === "object" && o.tagName.toLowerCase() === "img"){//����Ƿ���ͼƬ���͵�DOM����
		//��ǰ��ʾͼƬ�ĸ߶ȺͿ��
		var iCurWidth = o.width, iCurHeight = o.height;
		o.height = iCurHeight;
		//��ȡʵ��ͼƬ�ĸ߿�
		var oCreateImg = new Image();
		oCreateImg.src = o.src;
		var iOrigWidth = oCreateImg.width, iOrigHeight = oCreateImg.height;
		
		if(iCurWidth && iOrigWidth){//������Ϊ��Ϊ0 - ��ζ�ż��سɹ�
			//���㵱ǰ��ʵ�ʵ��ݺ��
			var scaleX = iCurWidth / iOrigWidth;
			var scaleY = iCurHeight / iOrigHeight;			
			//ʵ��ͼƬ����İ���
			//��������div
			var oRelDiv = document.createElement("div");
			oRelDiv.style.position = "relative";
			oRelDiv.style.width = iCurWidth + "px";
			oRelDiv.style.height = iCurHeight + 30 + "px";
			oRelDiv.style.top = "30px";
			//����ID����
			var ID = function(id){
				return document.getElementById(id);
			};
			//���뵽��ǰͼƬ����֮ǰ
			o.parentNode.insertBefore(oRelDiv, o);
			//��ʼ����������ø߿�
			var cropW = 80, cropH = 80;
			var posX = (iCurWidth - cropW)/2, posY = (iCurHeight - cropH)/2;
			//������Ҫ��HTMLԪ��
			var sInnerHtml = '<div style="font-size:12px; position:absolute; top:-24px; right:0;">��ת��<input id="zxxRotAngle" type="text" value="0" style="width:38px; height:15px; border:1px solid #a0b3d6; font-size:100%; padding:2px 0 1px 2px; margin-right:3px; color:#333333;" />��</div><canvas id="zxxImageCanvas" style="position:absolute;"></canvas><div id="zxxCropBox" style="height:'+cropH+'px; width:'+cropW+'px; position:absolute; left:'+posX+'px; top:'+posY+'px; border:1px solid black;"><div id="zxxDragBg" style="height:100%; background:white; opacity:0.3; filter:alpha(opacity=30); cursor:move;"></div><div id="dragLeftTop" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; left:-3px; top:-3px; cursor:nw-resize;"></div><div id="dragLeftBot" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; left:-3px; bottom:-3px; cursor:sw-resize;"></div><div id="dragRightTop" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; right:-3px; top:-3px; cursor:ne-resize;"></div><div id="dragRightBot" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; right:-3px; bottom:-3px; cursor:se-resize;"></div><div id="dragTopCenter" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; top:-3px; left:50%; margin-left:-3px; cursor:n-resize;"></div><div id="dragBotCenter" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; bottom:-3px; left:50%; margin-left:-3px; cursor:s-resize;"></div><div id="dragRightCenter" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; right:-3px; top:50%; margin-top:-3px; cursor:e-resize;"></div><div id="dragLeftCenter" style="position:absolute; width:4px; height:4px; border:1px solid #000; background:white; overflow:hidden; left:-3px; top:50%; margin-top:-3px; cursor:w-resize;"></div></div><input type="hidden" id="cropPosX" value="'+posX/scaleX+'" /><input type="hidden" id="cropPosY" value="'+posY/scaleY+'" /><input type="hidden" id="cropImageWidth" value="'+cropW/scaleX+'" /><input type="hidden" id="cropImageHeight" value="'+cropH/scaleY+'" />';
			//'
			//Ƕ��HTMLԪ��
			oRelDiv.innerHTML = sInnerHtml;
			//ͼƬ���²���
			var oCanvas = ID("zxxImageCanvas");
			if(window.ActiveXObject && window.G_vmlCanvasManager){
				//IE
				oCanvas = window.G_vmlCanvasManager.initElement(oCanvas); //ʹIE֧�ֶ�̬������canvasԪ��
			}
			oRelDiv.insertBefore(o, oCanvas);
			//---------------------------ͼƬ����װ�����-----------------------
			
			var fnCanvasRotate = function(canvas,img,rot){//canvas��ת�Ƕȵķ���
				//��ȡͼƬ�ĸ߿�
				var w = iCurWidth;
				var h = iCurHeight;
				//�Ƕ�תΪ����
				if(!rot){
					rot = 0;	
				}
				var rotation = Math.PI * rot / 180;
				var c = Math.round(Math.cos(rotation) * 1000) / 1000;
				var s = Math.round(Math.sin(rotation) * 1000) / 1000;
				//��ת��canvas��ǩ�Ĵ�С
				canvas.height = Math.abs(c*h) + Math.abs(s*w);
				canvas.width = Math.abs(c*w) + Math.abs(s*h);
				//��ͼ��ʼ
				var context = canvas.getContext("2d");
				context.save();
				//�ı����ĵ�
				if (rotation <= Math.PI/2) {
					context.translate(s*h,0);
				} else if (rotation <= Math.PI) {
					context.translate(canvas.width,-c*h);
				} else if (rotation <= 1.5*Math.PI) {
					context.translate(-c*w,canvas.height);
				} else {
					context.translate(0,-s*w);
				}
				//context.translate(canvas.width/2,canvas.height/2);
				//��ת90��

				context.rotate(rotation);
				//����
				context.drawImage(img, 0, 0, w, h);
				context.restore();
				img.style.display = "none";	
			};
			//������ת�Ƕ������
			ID("zxxRotAngle").onkeyup = function(){
				var v = parseInt(this.value, 10);
				if(!v){
					v = 0;	
				}
				//ִ�нǶ���ת
				fnCanvasRotate(oCanvas, o, v);
				if(v > 0){
					oRelDiv.style.height = oCanvas.height + 30 + "px";	
				}else{
					oRelDiv.style.height = iCurHeight + 30 + "px";	
				}
			};
			
			//��ק�����췽��
			//��ק�����������
			var params = {
				left: 0,
				top: 0,
				width:0,
				height:0,
				currentX: 0,
				currentY: 0,
				flag: false,
				kind: "drag"
			};
			//��ȡ���CSS���Է���
			var getCss = function(o,key){
				return o.currentStyle? o.currentStyle[key] : document.defaultView.getComputedStyle(o,false)[key]; 	
			};
			var startDrag = function(point, target, kind){	
				//point������㣬target�Ǳ������Ŀ�꣬��߶ȼ�λ�ûᷢ���ı�
				//�˴���target��������ק��target��ͬһĿ�꣬����params.left,params.top���Թ��ã�Ҳ���빲��
				//��ʼ�����
				params.width = getCss(target, "width");
				params.height = getCss(target, "height");
				//��ʼ������
				if(getCss(target, "left") !== "auto"){
					params.left = getCss(target, "left");
				}
				if(getCss(target, "top") !== "auto"){
					params.top = getCss(target, "top");
				}
				//target���ƶ�����
				point.onmousedown = function(event){
					params.kind = kind;
					params.flag = true;
					if(!event){
						event = window.event;
					}
					var e = event;
					params.currentX = e.clientX;
					params.currentY = e.clientY;
					//��ֹIE����ѡ�У���������קƽ��
					point.onselectstart = function(){
						return false;
					}
					return false;  
				};
				document.onmouseup = function(){
					params.flag = false;	
					if(getCss(target, "left") !== "auto"){
						params.left = getCss(target, "left");
					}
					if(getCss(target, "top") !== "auto"){
						params.top = getCss(target, "top");
					}
					params.width = getCss(target, "width");
					params.height = getCss(target, "height");
					
					//�������ı���ֵ
					posX = parseInt(target.style.left);
					posY = parseInt(target.style.top);
					cropW = parseInt(target.style.width);
					cropH = parseInt(target.style.height);
					if(posX < 0){
						posX = 0;	
					}
					if(posY < 0){
						posY = 0;
					}
					if((posX + cropW) > iCurWidth){
						cropW = iCurWidth - posX;	
					}
					if((posY + cropH) > iCurHeight){
						cropH = iCurHeight - posY;	
					}
					//��������
					posX = posX / scaleX;
					posY /= scaleY;
					cropW /= scaleX;
					cropH /= scaleY;
					//��ֵ
					ID("cropPosX").value = posX;
					ID("cropPosY").value = posY;
					ID("cropImageWidth").value = cropW;
					ID("cropImageHeight").value = cropH;
				};
				document.onmousemove = function(event){
					var e = event ? event: window.event;
					if(params.flag){
						var nowX = e.clientX, nowY = e.clientY;
						var disX = nowX - params.currentX, disY = nowY - params.currentY;
						if(params.kind === "n"){
							//������
							//�߶����ӻ��С��λ�������ƶ�
							target.style.top = parseInt(params.top) + disY + "px";
							target.style.height = parseInt(params.height) - disY + "px";
						}else if(params.kind === "w"){//������
							target.style.left = parseInt(params.left) + disX + "px";
							target.style.width = parseInt(params.width) - disX + "px";
						}else if(params.kind === "e"){//������
							target.style.width = parseInt(params.width) + disX + "px";
						}else if(params.kind === "s"){//������
							target.style.height = parseInt(params.height) + disY + "px";
						}else if(params.kind === "nw"){//��������
							target.style.left = parseInt(params.left) + disX + "px";
							target.style.width = parseInt(params.width) - disX + "px";
							target.style.top = parseInt(params.top) + disY + "px";
							target.style.height = parseInt(params.height) - disY + "px";
						}else if(params.kind === "ne"){//��������
							target.style.top = parseInt(params.top) + disY + "px";
							target.style.height = parseInt(params.height) - disY + "px";
							//��
							target.style.width = parseInt(params.width) + disX + "px";
						}else if(params.kind === "sw"){//��������
							target.style.left = parseInt(params.left) + disX + "px";
							target.style.width = parseInt(params.width) - disX + "px";
							//��
							target.style.height = parseInt(params.height) + disY + "px";
						}else if(params.kind === "se"){//��������
							target.style.width = parseInt(params.width) + disX + "px";
							target.style.height = parseInt(params.height) + disY + "px";
						}else{//�ƶ�
							target.style.left = parseInt(params.left) + disX + "px";
							target.style.top = parseInt(params.top) + disY + "px";
						}
					}
				}	
			};
			
			//����ק
			startDrag(ID("zxxDragBg"),ID("zxxCropBox"),"drag");
			//������
			startDrag(ID("dragLeftTop"),ID("zxxCropBox"),"nw");
			startDrag(ID("dragLeftBot"),ID("zxxCropBox"),"sw");
			startDrag(ID("dragRightTop"),ID("zxxCropBox"),"ne");
			startDrag(ID("dragRightBot"),ID("zxxCropBox"),"se");
			startDrag(ID("dragTopCenter"),ID("zxxCropBox"),"n");
			startDrag(ID("dragBotCenter"),ID("zxxCropBox"),"s");
			startDrag(ID("dragRightCenter"),ID("zxxCropBox"),"e");
			startDrag(ID("dragLeftCenter"),ID("zxxCropBox"),"w");
			
			//ͼƬ���ܱ�ѡ�У�Ŀ������ʹ��ק˳��
			ID("zxxImageCanvas").onselectstart = function(){
				return false;
			};
			o.onselectstart = function(){
				return false;
			};
		}//if end
	}//if end
};