package core.ioc.configuration 
{
	import core.ioc.configuration.configreaders.Bean;
	import core.ioc.configuration.Configuration;
	import core.ioc.configuration.InternalXMLConfig;
	import core.ioc.Context;
	import org.hamcrest.assertThat;
	/**
	 * ...
	 * @author Nikro
	 */
	public class ConfiguratorTest 
	{
		private var bean:Bean;
		
		public function ConfiguratorTest() 
		{
			
		}
		
		[Before]
		public function setUp():void
		{
			var context:Context = new Context();
			bean = new Bean();
		}
		
		[Test]
		public function testConfigure():void
		{	
			var configSource:XML = 
								<config>
	
									<bean class="core.external.io.IntOperator" id="IntOperator"/>
									<bean class="core.external.io.DoubleOperator" id="DoubleOperator"/>
									<bean class="core.external.io.PointOperator" id="PointOperator"/>
									
									<bean id="Header" class="core.external.io.StreamOperator">
										<add instance="IntOperator" with="addSerializer"/>
										<add instance="IntOperator" with="addSerializer"/>
										<add instance="DoubleOperator" with="addSerializer"/>
									</bean>
									
								</config>
							
			var config:InternalXMLConfig = new InternalXMLConfig(configSource);
							
			var configurator:Configuration = new Configuration();
			configurator.processConfig(config);
			
			assertThat('check IntOperator in context', Boolean(Context.instance.getObjectById('IntOperator')));
			assertThat('check DoubleOperator in context', Boolean(Context.instance.getObjectById('DoubleOperator')));
			assertThat('check PointOperator in context', Boolean(Context.instance.getObjectById('PointOperator')));
		}
		
	}

}