package  
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Entity;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author 
	 */
	public class GameCamera 
	{
		private var stage:Stage;
		private var _camera:Camera3D;
		private var controller:HoverController;
		
		private var lastPanAngle:Number = 90
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		
		private var _isCameraMovie:Boolean;
		
		private var cameraModel:CameraModel;
		private var target:ObjectContainer3D;
		private var deltaVecotr:Vector3D = new Vector3D(0, 0, 0);
		
		public function GameCamera(stage:Stage) 
		{
			this.stage = stage;
			
			initilize();
		}
		
		public function setTracingObject(target:ObjectContainer3D):void
		{
			this.target = target;
			//controller.lookAtObject = target;
			deltaVecotr.y = 500
		}
		
		private function initilize():void 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			
			cameraModel = new CameraModel();
			cameraModel.minimumZoom = 1;
			
			_camera = new Camera3D()
			_camera.lens.far = 1200000;
			_camera.lens.near = 1;
			controller = new HoverController(camera, null, 0, 4, cameraModel.baseDitance, 0);
			
			controller.lookAtPosition = new Vector3D();
			
			applyZoom();
		}
		
		public function render():void
		{
			
		
			if (_isCameraMovie) 
			{
				controller.panAngle = 0.3 * (stage.mouseX - lastMouseX) + lastPanAngle;
				controller.tiltAngle = 0.3 * (stage.mouseY - lastMouseY) + lastTiltAngle;
			}
			
			if(target)
				controller.lookAtPosition = target.position.clone().add(deltaVecotr);
				
			controller.autoUpdate = false;
			controller.update(true);
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			cameraModel.zoom -= e.delta;
			
			if (cameraModel.zoom < cameraModel.minimumZoom)
				cameraModel.zoom = cameraModel.minimumZoom;
				
			if (cameraModel.zoom > cameraModel.maximumZoom)
				cameraModel.zoom = cameraModel.maximumZoom;
				
			if (cameraModel.zoom < 6)
				controller.minTiltAngle = -90
			else
				controller.minTiltAngle = 0;
				
			applyZoom();
		}
		
		private function applyZoom():void
		{
			controller.distance = cameraModel.baseDitance * cameraModel.zoom / 100;
		}
		
		
		private function onMouseDown(event:MouseEvent):void
		{
			lastPanAngle = controller.panAngle;
			lastTiltAngle = controller.tiltAngle;
			
			lastMouseX = stage.mouseX;
			lastMouseY = stage.mouseY;
			
			_isCameraMovie = true;
			stage.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onStageMouseLeave(event:Event):void
		{
			_isCameraMovie = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		private function onMouseUp(event:MouseEvent):void
		{
			_isCameraMovie = false;
			stage.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
		}
		
		public function get camera():Camera3D 
		{
			return _camera;
		}
		
		public function get isCameraMovie():Boolean 
		{
			return _isCameraMovie;
		}
		
	}

}