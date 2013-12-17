/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package utilitarios;

/**
 *
 * @author Henrri
 */
public class cOsUtils {

    private static String OS = null;

    public static String getOsName() {
        if (OS == null) {
            OS = System.getProperty("os.name");
        }
        return OS;
    }

//    public static boolean isWindows() {
//        return getOsName().startsWith("Windows");
//    }
    public   boolean isWindows() {
        return (OS.indexOf("win") >= 0);
    }

    public   boolean isMac() {
        return (OS.indexOf("mac") >= 0);
    }

    public   boolean isUnix() {
        return (OS.indexOf("nux") >= 0);
    }
//   public static boolean isUnix(); // and so on;
}
