/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.controller
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import org.puremvc.as3.demos.flex.cf.querycfc.model.RemoteProxy;
	import org.puremvc.as3.demos.flex.cf.querycfc.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.querycfc.view.UserListMediator;
	import org.puremvc.as3.demos.flex.cf.querycfc.view.UserFormMediator;
	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		 override public function execute( note:INotification ):void
		 {
		 	
		 	var app:QueryCFC = note.getBody() as QueryCFC;
		 	
		 	facade.registerProxy( new RemoteProxy() );
			
			facade.registerMediator( new UserFormMediator( app.userForm ));
		 	facade.registerMediator( new UserListMediator( app.userList ) );
		 }
	}
}