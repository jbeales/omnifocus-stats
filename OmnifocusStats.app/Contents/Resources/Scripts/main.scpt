JsOsaDAS1.001.00bplist00�Vscript_�


const app = Application.currentApplication();
app.includeStandardAdditions = true

	
function getDataFolderPathString() {
	return app.pathTo("home folder").toString() + app.pathTo("application support").toString() + "/OmniFocusStats";	
}



const StatsProcessor = Library("StatsProcessor");
StatsProcessor.importCurrentPeriodToDataFolder( getDataFolderPathString() );


app.displayAlert('done');

                              �jscr  ��ޭ