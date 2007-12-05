/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.view
{
	import flash.events.Event;
	
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.observer.Notification;
	
	import org.puremvc.as3.demos.flex.cf.querycfc.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.querycfc.model.RemoteProxy;
	import org.puremvc.as3.demos.flex.cf.querycfc.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.cf.querycfc.view.components.UserList;

	public class UserListMediator extends Mediator implements IMediator
	{
		private var remoteProxy:RemoteProxy;
		
		public static const NAME:String = 'UserListMediator';
		
		public function UserListMediator( viewComponent:Object )
		{
			super( viewComponent );
			
			// Add listeners to the view component i.e. userList combobox
			userList.addEventListener( UserList.SELECT, onSelect );
			userList.addEventListener( UserList.NEW, onNew );
			userList.addEventListener( UserList.DELETE, onDelete );
			
			// Retrieve the instance of the applications ResProxy
			remoteProxy = facade.retrieveProxy( RemoteProxy.NAME ) as RemoteProxy;
			userList.users = remoteProxy.users;
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get userList():UserList
		{
			return viewComponent as UserList;
		}
		
		private function onSelect( event:Event ):void
		{
			sendNotification( ApplicationFacade.USER_SELECTED, userList.selectedUser );
		}
		
		private function onNew( event:Event ):void
		{
			var user:UserVO = new UserVO();
			sendNotification( ApplicationFacade.NEW_USER, user );
		}
		
		private function onDelete( event:Event ):void
		{
			sendNotification( ApplicationFacade.DELETE_USER, userList.selectedUser );
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.CANCEL_SELECTED,
					ApplicationFacade.USER_ADDED,
					ApplicationFacade.USER_UPDATED,
					ApplicationFacade.USER_DELETED
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.CANCEL_SELECTED:
					userList.deSelect();
					break;
					
				case ApplicationFacade.USER_ADDED:
					userList.deSelect();
					userList.showSuccess( "Add" );
					break;
					
				case ApplicationFacade.USER_UPDATED:
					userList.deSelect();
					userList.showSuccess( "Update" );
					break;
					
				case ApplicationFacade.USER_DELETED:
					userList.deSelect();
					userList.showSuccess( "Delete" );
					break;
			}
		}
		
	}
}