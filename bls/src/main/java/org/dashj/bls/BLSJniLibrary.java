package org.dashj.bls;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BLSJniLibrary {
    private static final Logger log = LoggerFactory.getLogger(BLSJniLibrary.class);
    public static String LIBRARY_NAME = "dashjbls";
    public static String VERSION = "1.3.5-SNAPSHOT";

    static private boolean isLibraryLoaded = false;

    public static boolean isIsLibraryLoaded() {
        return isLibraryLoaded;
    }

    public static void loadLibrary() {
        loadLibrary(true);
    }

    public static void loadLibrary(boolean throwExceptionOnFailure) {
        try {
            System.loadLibrary(LIBRARY_NAME);
            log.info("{} was loaded successfully", LIBRARY_NAME);
            isLibraryLoaded = true;
        } catch (UnsatisfiedLinkError | SecurityException x) {
            isLibraryLoaded = false;
            log.error("{} was not loaded successfully", LIBRARY_NAME);
            if (throwExceptionOnFailure)
                throw new RuntimeException(x.getMessage(), x);
        }
    }

    public static void init() {
        init(true);
    }

    public static void init(boolean throwExceptionOnFailure) {
        log.info("Initializing BLS JNI Library");
        if (!isLibraryLoaded) {
            loadLibrary(throwExceptionOnFailure);
        }
        if (isLibraryLoaded) {
            BLS.init();
        }
    }
}
