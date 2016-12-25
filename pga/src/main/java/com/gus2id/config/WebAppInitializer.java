package com.gus2id.config;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
	
	@Override
	protected Class<?>[] getRootConfigClasses() {
		return null;
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return new Class<?>[] { SpringConfig.class };
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected Filter[] getServletFilters() {

		CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
		characterEncodingFilter.setEncoding("UTF-8");

		return new Filter[] { characterEncodingFilter };

	}
}

// public void onStartup(ServletContext container) {
// System.out.println("initialize");
// // Create the 'root' Spring application context
// AnnotationConfigWebApplicationContext rootContext = new
// AnnotationConfigWebApplicationContext();
//// rootContext.register(ServiceConfig.class, JPAConfig.class,
// SecurityConfig.class);
//
// // Manage the lifecycle of the root application context
// container.addListener(new ContextLoaderListener(rootContext));
//
// // Create the dispatcher servlet's Spring application context
// AnnotationConfigWebApplicationContext dispatcherServlet = new
// AnnotationConfigWebApplicationContext();
// dispatcherServlet.register(SpringConfig.class);
//
// // Register and map the dispatcher servlet
// ServletRegistration.Dynamic dispatcher = container.addServlet("dispatcher",
// new DispatcherServlet(dispatcherServlet));
// dispatcher.setLoadOnStartup(1);
// dispatcher.addMapping("/");
//
// }
//
// }
