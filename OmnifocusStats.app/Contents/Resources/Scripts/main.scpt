JsOsaDAS1.001.00bplist00�Vscript_y


const app = Application.currentApplication();

app.includeStandardAdditions = true

console.log('test' + app.pathTo("home folder").toString());


const StatsProcessor = Library("StatsProcessor");
StatsProcessor.importCurrentDay('OmniFocusStats');




let dataPath = app.pathTo("home folder").toString()

console.log('ok');

console.log(dataPath)

app.displayAlert('done');

                              � jscr  ��ޭ