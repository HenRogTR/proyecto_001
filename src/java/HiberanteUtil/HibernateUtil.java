/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package HiberanteUtil;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;
import org.hibernate.stat.Statistics;

/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author Henrri
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    private static Statistics stats;

    static {
        try {
            // Create the SessionFactory from standard (hibernate.cfg.xml) 
            // config file.
            // sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
            Configuration cfg = new Configuration();

            sessionFactory = cfg.configure("hibernate.cfg.xml").buildSessionFactory();
            stats = sessionFactory.getStatistics();
            stats.setStatisticsEnabled(true);
        } catch (Throwable ex) {
            // Log the exception. 
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
//        if(sessionFactory==null){
//            synchronized (HibernateUtil.class){
//                if(sessionFactory==null){
//                    sessionFactory=new AnnotationConfiguration().configure().buildSessionFactory();
//                }
//            }
//        }
        return sessionFactory;
    }
}
