package gameui.mainmenu 
{
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.core.pick.ShaderPicker;
	import away3d.entities.Sprite3D;
	import away3d.filters.BloomFilter3D;
	import away3d.filters.Filter3DBase;
	import away3d.filters.MotionBlurFilter3D;
	import away3d.lights.DirectionalLight;
	import away3d.lights.PointLight;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.methods.FresnelSpecularMethod;
	import away3d.materials.methods.PhongSpecularMethod;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.SkyBox;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import characters.Actor;
	import characters.view.PlanetViewController;
	import characters.view.ViewController;
	import com.greensock.TweenLite;
	import core.fileSystem.IFS;
	import demo.PlanetoidFactory;
	import display.SceneController;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import gameui.MenuPanel;
	import gameui.NewsPanel;
	import gameui.PlayerPanel;
	import ui.Button;
	import ui.LineDrawer;
	import ui.style.Style;
	import ui.style.StylesCollector;
	import ui.UIComponent;
	
	public class MainMenuView extends UIComponent 
	{
		private var menu:Menu;
		
		private var selectionOutLine:LineDrawer;
		private var selectionToTargetLine:LineDrawer;
		private var iconLine:LineDrawer;
		
		private var icon:Button;
		private var enter:Button;
		
		public var view:View3D;
		
		private var lights:DirectionalLight;
		private var lightPicker:StaticLightPicker;
		private var selectionLight:PointLight;
		
		private var skybox:SkyBox;
		private var shipView:ObjectContainer3D;
		private var earth:Actor;
		private var starBase:Actor;
		private var moon:Actor;
		
		private var playerPanel:PlayerPanel;
		private var menuPanel:MenuPanel;
		private var newsPanel:NewsPanel;
		
		
		public var displayController:SceneController;
		
		[Inject]
		public var vfs:IFS
		
		[Inject]
		public var styles:StylesCollector;
		
		public function MainMenuView(style:Style=null) 
		{
			inject(this);
			super(style);
		}
		
		private function createViewport():void
		{
			view = new View3D(null, null, null, false, Context3DProfile.BASELINE_EXTENDED);
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			view.antiAlias = 100;
			view.mousePicker = new ShaderPicker();
			
			displayController = new SceneController(view);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			enter.addEventListener(MouseEvent.MOUSE_DOWN, onEnterPress);
		}
		
		private function onEnterPress(e:MouseEvent):void 
		{
			
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			createViewport();
			createPlanets();
			createShip();
			createStarField();
			
			menu = new Menu(styles.getStyle("mainMenu"));
			
			skybox = new SkyBox(new BitmapCubeTexture(vfs.getFile("res/textures/skybox/space/posX.jpg").content, vfs.getFile("res/textures/skybox/space/negX.jpg").content,
									vfs.getFile("res/textures/skybox/space/posY.jpg").content, vfs.getFile("res/textures/skybox/space/negY.jpg").content,
									vfs.getFile("res/textures/skybox/space/posZ.jpg").content, vfs.getFile("res/textures/skybox/space/negZ.jpg").content));
									
									
			selectionOutLine = new LineDrawer(styles.getStyle("mainMenu"), null, true);
			selectionToTargetLine = selectionToTargetLine = new LineDrawer(styles.getStyle("mainMenu"));
			iconLine = new LineDrawer(styles.getStyle("mainMenu"), null, true);
			
			icon = new Button(styles.getStyle("mainMenuButton"), "ICON");
			enter = new Button(styles.getStyle("mainMenuButton"), "ПЕРЕЙТИ");
			
			icon.width = icon.height = 50;
			icon.selected = true;
			icon.visible = enter.visible = false;
			shipView.z -= 50;
			
			playerPanel = new PlayerPanel();
			menuPanel = new MenuPanel();
			newsPanel = new NewsPanel();
			
			blikIn();
		}
		
		private function createShip():void
		{
			shipView = vfs.getFile('res/models/ships/mainmenu/mesh.awd').content;
			var viewContorller:ViewController = new ViewController(shipView);
			starBase = new Actor(viewContorller);
			
			selectionLight = shipView.getChildAt(2).getChildAt(0) as PointLight;
			
			shipView.getChildAt(0).rotationY = 90 - 65 - 90 - 15;
			shipView.getChildAt(2).rotationY = 90 - 65 - 90 - 15;
			shipView.getChildAt(1).rotationY = 90 - 65 - 90 - 15;
			
			shipView.rotationX -= 25;
			shipView.rotationZ -= 15;
		}
		
		
		private function createPlanets():void 
		{
			var earthFresnelSpecularMethod:FresnelSpecularMethod = new FresnelSpecularMethod( true, new PhongSpecularMethod() );
			earthFresnelSpecularMethod.fresnelPower = 5;
			earthFresnelSpecularMethod.normalReflectance = 0.1;
			
			lights = new DirectionalLight( -1, 0.2, -.4);
			lights.diffuse = 3;
			lights.ambient = 0.17
			
			view.scene.addChild(lights);
			view.camera.position = new Vector3D(0, 0, -500);
			view.camera.lookAt(new Vector3D());
			
			lightPicker = new StaticLightPicker([lights]);
			addToContext(lightPicker);
			
			var planetFactory:PlanetoidFactory = new PlanetoidFactory();
			
			earth = planetFactory.build("earthhires", 1, 200, 0, 25, true)
			var planetView:PlanetViewController = earth.getController("PlanetViewController") as PlanetViewController;
			(planetView.body.material as TextureMaterial).specularMethod = earthFresnelSpecularMethod;
			
			planetView.x -= 100;
			planetView.z += 150;
			planetView.y += 150;
			
			planetView.displayObject.rotationX -= 15;
			
			moon = planetFactory.build("moon", 0.5, 100, 0, 10, false, true, 0xCCCCCC);
			
			var moonView:PlanetViewController = moon.getController("PlanetViewController") as PlanetViewController;
			(moonView.body.material as TextureMaterial).specularMethod = earthFresnelSpecularMethod;
			
			moonView.x = -100;
			moonView.x = 100;
			moonView.x = 150;
		}
		
		private function createStarField():void
		{
			var bitmapData:BitmapData = blackToTransparent( vfs.getFile('res/textures/space/star.jpg').content );
			var starMaterial:TextureMaterial = new TextureMaterial( new BitmapTexture( bitmapData ) );
			starMaterial.alphaBlending = true;
			for( var i:uint = 0; i < 250; i++ ) {
				// Define unique star.
				var seed:Number = Math.random() + 0.1;
				var star:Sprite3D = new Sprite3D( starMaterial, 75 * seed, 75 * seed );
				view.scene.addChild( star );
				
				star.x = rand( -2500, 2500);
				star.y = rand( -2500, 2500);
				star.z = 2500;
			}
		}
		
		private function rand( min:Number, max:Number ):Number {
		    return (max - min)*Math.random() + min;
		}
		
		private function blackToTransparent( original:BitmapData ):BitmapData {
			var bmd:BitmapData = new BitmapData( original.width, original.height, true, 0xFFFFFFFF );
			bmd.copyChannel( original, bmd.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA );
			return bmd;
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			menu.addEventListener(Event.SELECT, onMenuSelect);
		}
		
		private function onMenuSelect(e:Event):void 
		{
			var i:int;
			var selectedMenuItem:Button = menu.selectedButton;
			
			selectionOutLine.path.clear();
			selectionToTargetLine.path.clear();
			iconLine.path.clear();
			
			var borderSize:Number = 6;
			
			//trace(selectedMenuItem.x - borderSize + menu.x, selectedMenuItem.width + borderSize + menu.x, selectedMenuItem.width);
			selectionOutLine.path.push(selectedMenuItem.x - borderSize + menu.x - 1, selectedMenuItem.y - borderSize + menu.y - 1);
			selectionOutLine.path.push(selectedMenuItem.width + borderSize + menu.x, selectedMenuItem.y - borderSize + menu.y - 1);
			selectionOutLine.path.push(selectedMenuItem.width + borderSize + menu.x, selectedMenuItem.y + selectedMenuItem.height + borderSize + menu.y);
			selectionOutLine.path.push(selectedMenuItem.x - borderSize + menu.x - 1, selectedMenuItem.y + selectedMenuItem.height + borderSize + menu.y);
			
			
			var find:String = "";
			
			if (menu.selectedButton == menu.hangar)
				find = 'hangar';
				
			if (menu.selectedButton == menu.cabinsCompany)
				find = 'cabin';
				
			if (menu.selectedButton == menu.commandCenter)
				find = 'command';
				
			if (menu.selectedButton == menu.researchCetner)
				find = 'research';
				
			if (menu.selectedButton == menu.shop)
				find = 'shop';
				
			var pos:Vector3D;
			for (i = 0; i < selectionLight.parent.numChildren; i++)
			{
				if (selectionLight.parent.getChildAt(i).name == find)
				{
					pos = selectionLight.parent.getChildAt(i).position;
					TweenLite.to(selectionLight, 0.5, { x:pos.x, y:pos.y, z:pos.z } );
					pos = selectionLight.parent.getChildAt(i).scenePosition;
					
					
				}
			}
			
			pos = view.project(pos);
			
			pos.y += 50
			var wid:Number = 75;
			
			selectionToTargetLine.path.push(selectedMenuItem.x + selectedMenuItem.width + borderSize + menu.x, selectedMenuItem.y + (selectedMenuItem.height + borderSize + 1) / 2 + menu.y, false);
			selectionToTargetLine.path.push(pos.x, selectedMenuItem.y + (selectedMenuItem.height + borderSize + 1) / 2 + menu.y);
			selectionToTargetLine.path.push(pos.x, pos.y, true);
				
			iconLine.path.push(pos.x - wid / 2 , pos.y);
			iconLine.path.push(pos.x - wid / 2, pos.y - wid);
			iconLine.path.push(pos.x + wid / 2 , pos.y - wid);
			iconLine.path.push(pos.x + wid / 2, pos.y);
			
			icon.visible = enter.visible = true;
			
			icon.x = pos.x - icon.width/2;
			icon.y = pos.y - icon.height - (wid - icon.height) / 2;
			
			enter.x = icon.x + icon.width + (wid - icon.height);
			enter.y = icon.y;
		}
		
		private function blikIn():void 
		{
			TweenLite.to(selectionLight, 2, { fallOff:selectionLight.fallOff + 4, onComplete:blikOut } );
		}
		
		private function blikOut():void 
		{
			TweenLite.to(selectionLight, 2, { fallOff:selectionLight.fallOff - 4, onComplete:blikIn } );
		}
		
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			view.filters3d = new <Filter3DBase>[new BloomFilter3D(8, 8, 0.5, 4, 4), new MotionBlurFilter3D(.80)];
			
			update();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addChild(view);
			//removeChild(view);
			
			view.scene.addChild(skybox);
			displayController.addDisplayObject(earth);
			displayController.addDisplayObject(moon);
			displayController.addDisplayObject(starBase);
			
			addComponent(playerPanel);
			addComponent(menuPanel);
			
			addChild(menu);
			
			addComponent(selectionOutLine);
			addComponent(selectionToTargetLine);
			addComponent(iconLine);
			
			addChild(icon);
			addChild(enter);
			//addChild(new AwayStats(view));
			
			addComponent(newsPanel);
		}
		
		override public function update():void 
		{
			super.update();
			
			displayController.update();
			layoutChildren();
			
			//shipView.rotationY++;
		}
		
		override protected function layoutChildren():void 
		{
			super.layoutChildren();
			
			if (!stage)
				return;
			
			menu.x = 100;
			menu.y = stage.stageHeight - 350;
			
			menuPanel.x = (stage.stageWidth - menuPanel.width) / 2;
			
			newsPanel.x = (stage.stageWidth - newsPanel.width - 10);
			newsPanel.y = stage.stageHeight - newsPanel.height - 10;
		}
		
	}

}