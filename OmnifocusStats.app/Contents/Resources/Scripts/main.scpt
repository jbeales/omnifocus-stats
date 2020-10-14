JsOsaDAS1.001.00bplist00�Vscript_T


const app = Application.currentApplication();
app.includeStandardAdditions = true

	
function getDataFolderPathString() {
	return app.pathTo("home folder").toString() + app.pathTo("application support").toString() + "/OmniFocusStats";	
}


function writeChartFile(filename, chartString) {
	const dataStoreFile = app.openForAccess( Path( `${getDataFolderPathString()}/${filename}`), { writePermission: true });
	app.setEof(dataStoreFile, { to: 0 });		
	app.write(chartString, { to: dataStoreFile, startingAt: app.getEof(dataStoreFile) })
	app.closeAccess(dataStoreFile) 
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









                              jjscr  ��ޭ