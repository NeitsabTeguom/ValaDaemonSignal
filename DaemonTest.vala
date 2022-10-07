using GLib;

namespace Daemon {

 private static MainLoop mainloop;

 private static void Write(string message)
 {
  // Open or create a file for appending:
  File file = File.new_for_path ("my-test.txt");
  try {
	// Append a new line on each run:
	FileOutputStream os = file.append_to (FileCreateFlags.NONE);
	os.write ((message+"\n").data);
  } catch (Error e) {
	print ("Error: %s\n", e.message);
  }
 }

 private static void on_exitINT (int signum)
 {
  Write("Exiting INT");

  mainloop.quit ();
 }
 
 private static void on_exitTERM (int signum)
 {
  Write("Exiting TERM");

  mainloop.quit ();
 }

public static int main (string[] args)
 {
  // set timezone to avoid that strftime stats /etc/localtime on every call
  Environment.set_variable ("TZ", "/etc/localtime", false);

  Write("Init Signals");

  Process.signal(ProcessSignal.INT, on_exitINT); // Ctrl+c
  Process.signal(ProcessSignal.TERM, on_exitTERM); // DAEMON stop

  Write("Init mainloop");
  
  // Creating a GLib main loop with a default context
  mainloop = new MainLoop (null, false);
  
  Write("Run mainloop");
  
  // Start GLib mainloop
  mainloop.run ();

  Write("Bye ...");
 
  return 0;        
 }
}
