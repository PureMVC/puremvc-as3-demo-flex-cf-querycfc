/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.patterns.observer.Notification;
	
	import org.puremvc.as3.demos.flex.cf.querycfc.controller.*;

	public class ApplicationFacade extends Facade implements IFacade
	{
		/**
		 * Notification name constants
		 */
		 public static const STARTUP:String         = "startUp";
		 
		 // User List
		 public static const USER_SELECTED:String   = "userSelected";
		 public static const NEW_USER:String        = "newUser";
		 public static const DELETE_USER:String     = "deleteUser";
		 public static const USER_DELETED:String    = "userDeleted";
		 
		 
		 // User Form
		 public static const ADD_USER:String        = "addUser";
		 public static const USER_ADDED:String      = "userAdded";
		 public static const UPDATE_USER:String     = "updateUser";
		 public static const USER_UPDATED:String    = "userUpdated";
		 
		 public static const CANCEL_SELECTED:String = "cancelSelected";
		 
		/**
		 * Singleton ApplicationFacade Factory Method
		 */
		public static function getInstance():ApplicationFacade
		{
			if ( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
			
			registerCommand( STARTUP, StartupCommand );
			
			registerCommand( ADD_USER, AddUserCommand );
			registerCommand( UPDATE_USER, UpdateUserCommand );
			registerCommand( DELETE_USER, DeleteUserCommand );
		}

		public function startup( app:QueryCFC ):void
		{
			sendNotification( STARTUP, app );
		}
		
	}
}