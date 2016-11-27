namespace LAIR{
	class FileDB {
		private List<Image> imgRes = new List<Image>();
		private LairFile imgListPath = null;
		private LairFile sndListPath = null;
		private LairFile ttfListPath = null;
		public FileDB(string imgList, string sndList, string ttfList){
			var imgfile = new LairFile.WithPath(imgList);
			if (imgfile.CheckPath()){
				imgListPath = imgfile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", imgfile.GetPath());
			}
			var sndfile = new LairFile.WithPath(sndList);
			if (sndfile.CheckPath()){
				sndListPath = sndfile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", sndfile.GetPath());
			}
			var ttffile = new LairFile.WithPath(ttfList);
			if (ttffile.CheckPath()){
				ttfListPath = ttffile;
			}else{
				stderr.printf ("File '%s' doesn't exist.\n", ttffile.GetPath());
			}
		}
		public bool LoadFiles(){
			return false;
			List<string> imgStrings = imgListPath.LoadLineDelimitedConfig();
			foreach(string image in imgStrings){
				imgRes.append(new Image(image));
			}
/*			List<string> sndStrings = LoadLineDelimitedConfig(sndListPath);
			foreach(var sound in LoadLineDelimitedConfig(sndListPath)){
				sndRes.append(new Sound(sound);
			}
/*			List<string> ttfStrings = LoadLineDelimitedConfig(ttfListPath);
			foreach(var font in LoadLineDelimitedConfig(ttfListPath)){
				ttfRes.append(new Font(font));
			}*/
		}
		
	}
}