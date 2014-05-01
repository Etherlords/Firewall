package core.ioc.configuration
{
	import core.ioc.configuration.configreaders.Bean;
	import core.ioc.Context;

	public class BeanTest 
	{
		private var bean:Bean;
		
		public function BeanTest() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			var context:Context = new Context();
			bean = new Bean();
		}
		
		[Test]
		public function testReadBean():void
		{	
			var intOperatorConfig:XML = <bean id="StaticIntOperator" class="core.external.io.IntOperator"/>
			
			bean.read(intOperatorConfig);
			
			var config:XML = 	<bean id="Header" class="core.external.io.StreamOperator">
									<add class="core.external.io.IntOperatorr" with="addSerializer"/>
									<add instance="StaticIntOperator" with="addSerializer"/>
								</bean>
			
			bean.read(config);
		}
		
	}

}