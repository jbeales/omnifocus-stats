JsOsaDAS1.001.00bplist00�Vscript_�/**
 * Gets data on the current state of the OmniFocus library, and how it has changed since the last run
 * and saves it to a file called stats.json in the dataFolder.
 */


function importCurrentPeriodToDataFolder( dataFolder ) {

	

	const app = Application.currentApplication();
	app.includeStandardAdditions = true
	
	
	// Set up the datastore
	const dataStoreFileName = getDataFilePathString();
	ensureDataStoreExists();
	
	// load up the archive of data so we can manipulate it
	let archive = readDataStore();
	
	
	
	// actual processing for the day
	storeCurrentStats( getCurrentStats() );
	


	function getCurrentStats() {
	
		const now = new Date();
		
		const ofdoc = Application('OmniFocus').defaultDocument,
			  tasks = ofdoc.flattenedTasks,
			  stats = {
			  	recordedAt: now.toJSON(),
			  	total: {
					tasksCompleted: 0,
					tasksRemaining: 0,
					allTasks: tasks.length
				
				},
				
				period: {
					tasksCreated: 0,
					tasksCompleted: 0,
					tasksDropped: 0,
					length: -1
				}
			  	
			  };
			  
		const remainingTasks = tasks.whose({
			effectivelyCompleted: false,
			effectivelyDropped: false
		});
		stats.total.tasksRemaining = remainingTasks.length;
		
		const completedTasks = tasks.whose({
			effectivelyCompleted: true
		});
		stats.total.tasksCompleted = completedTasks.length;
		
		
		// Get when we last imported stats so we can get per-period stuff
		let lastrun = getLastRunTimestamp();
		
		if(lastrun) {
			const newTasks = tasks.whose({
				creationDate: { _greaterThanEquals: lastrun }
			});
			stats.period.tasksCreated = newTasks.length;
		
			const recentlyCompletedTasks = tasks.whose({
				completionDate: { _greaterThanEquals: lastrun }
			});
			stats.period.tasksCompleted = recentlyCompletedTasks.length;
		
			const recentlyDroppedTasks = tasks.whose({
				droppedDate: { _greaterThanEquals: lastrun }
			});
			stats.period.tasksDropped = recentlyDroppedTasks.length;
		
			// Set the period length in seconds
			stats.period.length = Math.round( (now.getTime() - lastrun.getTime()) / 1000 );

		}
		
		
		
		return stats;
				
	};
	
	
	
	function storeCurrentStats( currentStats ) {
	
		if(!archive) {
			archive = readDataStore();
		}
	
		if( !Array.isArray(archive) ) {
			archive = [];
		}
		
		archive.push(currentStats);
		writeDataStore(archive);
			
	}
	
	
		
	
	function getDataFilePathString() {
		return dataFolder + "/stats.json";
	}
	
	function writeDataStore(json) {
		const dataStoreFile = app.openForAccess( Path(getDataFilePathString()), { writePermission: true });

		app.setEof(dataStoreFile, { to: 0 });		
		app.write(JSON.stringify(json), { to: dataStoreFile, startingAt: app.getEof(dataStoreFile) })
		app.closeAccess(dataStoreFile)

 
	}
	
	function ensureDataStoreExists() {
		const finder = Application("Finder");
		
		if( ! finder.exists( Path( dataFolder ) ) ) {
			// finder.make() gives a cryptic Apple Events error. Using shell.
			// It would probably be smart to escape somethin here since the folder path includes
			// the argument passed to the main constructor.
			app.doShellScript('mkdir "' + dataFolder + '"');
			writeDataStore([]);	
		}
	}
	
	
	function readDataStore() {
		// app.read() gives an End-of-File error here and can't figure out why. This works. 
		return JSON.parse( app.doShellScript('cat "' + getDataFilePathString() + '"') );
	}
	
	
	function getLastRunTimestamp() {
		if(archive.length > 0) {
			let lastItem = archive[archive.length - 1];
			return new Date(lastItem.recordedAt);
		}
		
		return false;
	}
	

}


                              �jscr  ��ޭ