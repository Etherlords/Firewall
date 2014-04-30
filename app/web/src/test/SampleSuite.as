package 
{

	import core.ioc.configuration.BeanTest;
	import core.ioc.configuration.ConfiguratorTest;
	import core.external.io.DataReaderTest;
	import core.external.io.DoubleTest;
	import core.external.io.IntTest;
	import core.external.io.PointTest;
	import core.external.io.StreamOperatorTest;
	import core.external.io.UTFStringOperatorTest;
	import io.FileChangeCheckerTest;
	import sample.SampleTest;

	
	[Suite] 
	[RunWith("org.flexunit.runners.Suite")]
	public class SampleSuite
	{
		
		public var sampleTest:SampleTest;
		
		
		
		public var fileCheckerTest:FileChangeCheckerTest;
		
		
		public var intTest:IntTest;
		public var doubleTest:DoubleTest;
		public var pointTest:PointTest;
		public var utfStringOperator:UTFStringOperatorTest;
		public var streamTest:StreamOperatorTest;
		
		public var dateReaderTest:DataReaderTest;
		
		public var castTest:CastTest;
		
		public var beanTest:BeanTest;
		public var configTest:ConfiguratorTest;
	}

}