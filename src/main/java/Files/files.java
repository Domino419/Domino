package Files;

public class files {

private String FileName;
private String contents;

public files() {
   super();
	}

public files(String FileName,String contents ) {
	super();
	this.FileName = FileName;
	this.contents = contents;
  }

public String getFileName() {
	return FileName;
}

public void setFileName(String fileName) {
	FileName = fileName;
}

public String getContents() {
	return contents;
}

public void setContents(String contents) {
	this.contents = contents;
}
}
