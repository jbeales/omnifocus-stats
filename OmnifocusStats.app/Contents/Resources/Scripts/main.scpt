JsOsaDAS1.001.00bplist00�Vscript_q


const app = Application.currentApplication();
app.includeStandardAdditions = true

	
function getDataFolderPathString() {
	return app.pathTo("home folder").toString() + app.pathTo("application support").toString() + "/OmniFocusStats";	
}


function writeChartFile(filename, chartString) {

	// Write with UTF-8 support.  Thanks: https://stackoverflow.com/questions/29076947/jxa-set-utf-8-encoding-when-writing-files
	let str = $.NSString.alloc.initWithUTF8String(chartString);
	str.writeToFileAtomicallyEncodingError(`${getDataFolderPathString()}/${filename}`, true, $.NSUTF8StringEncoding, null);

}



const StatsProcessor = Library("StatsProcessor");
StatsProcessor.setDataFolder(getDataFolderPathString());

console.log('done');

// Import current period if the last import was at least 23 hours ago, (1 hour flexibility 
// to handle any scheduling imprecision
if(StatsProcessor.getLastRunTimestamp() <= ( new Date().getTime() - (3600*23*1000))) {
	StatsProcessor.importCurrentPeriod();
}



let lastMonth = StatsProcessor.getArchive().slice(-30);
const BarChartGenerator = Library("BarChart");

let remainingItemsChartData = [];

lastMonth.forEach(function(day) {
	remainingItemsChartData.push({
		'date' : day.recordedAt,
		'value': day.total.tasksRemaining
	});
});


let remainingItemsChart = "Remaining Items:\n" + BarChartGenerator.chartFromArray( remainingItemsChartData, 30, 12 );
writeChartFile('remaining-items-chart.txt', remainingItemsChart);


let completedItemsChartData = [];
lastMonth.forEach(function(day) {
	completedItemsChartData.push({
		'date' : day.recordedAt,
		'value': day.period.tasksCompleted
	});
});
let completedItemsChart = "Completed per Day:\n" + BarChartGenerator.chartFromArray( completedItemsChartData, 30, 7 );
writeChartFile('completed-items-chart.txt', completedItemsChart);

let addedItemsChartData = [];
lastMonth.forEach(function(day) {
	addedItemsChartData.push({
		'date' : day.recordedAt,
		'value': day.period.tasksCreated
	});
});
let addedItemsChart = "Added per Day:\n" + BarChartGenerator.chartFromArray( addedItemsChartData, 30, 7 );
writeChartFile('added-items-chart.txt', addedItemsChart);









                              � jscr  ��ޭ