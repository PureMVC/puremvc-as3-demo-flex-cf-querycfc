/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.view
{
	import org.puremvc.as3.demos.flex.cf.querycfc.ApplicationFacade;
	import org.puremvc.as3.demos.flex.cf.querycfc.model.vo.UserVO;
	import org.puremvc.as3.demos.flex.cf.querycfc.view.components.UserForm;
	
	import flash.events.Event;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.mediator.Mediator;

	public class UserFormMediator extends Mediator implements IMediator
	{	
		public static const NAME:String = 'UserFormMediator';
		
		public function UserFormMediator( viewComponent:Object )
		{
			super( viewComponent );
			
			userForm.addEventListener( UserForm.ADD, onAdd );
			userForm.addEventListener( UserForm.CANCEL, onCancel );
			userForm.addEventListener( UserForm.UPDATE, onUpdate );
		}
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		public function get userForm():UserForm
		{
			return viewComponent as UserForm;
		}
		
		private function onAdd( event:Event ):void
		{
			var user:UserVO = userForm.user;
			sendNotification( ApplicationFacade.ADD_USER, user );
			clearForm();
		}
		
		private function onCancel( event:Event ):void
		{
			sendNotification( ApplicationFacade.CANCEL_SELECTED );
			clearForm();
		}
		
		private function onUpdate( event:Event ):void
		{
			var user:UserVO = userForm.user;
			sendNotification( ApplicationFacade.UPDATE_USER, user );
			clearForm();
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.USER_SELECTED,
					ApplicationFacade.NEW_USER,
					ApplicationFacade.USER_DELETED
				   ];
		}
		
		override public function handleNotification( note:INotification ):void
		{
			switch ( note.getName() )
			{
				case ApplicationFacade.USER_SELECTED:
					userForm.user = note.getBody() as UserVO;
					userForm.mode = UserForm.MODE_EDIT;
					userForm.username.setFocus();
					break;
					
				case ApplicationFacade.NEW_USER:
					userForm.user = note.getBody() as UserVO;
					userForm.mode = UserForm.MODE_ADD;
					userForm.username.setFocus();
					break;
					
				case ApplicationFacade.USER_DELETED:
					userForm.user = null;
					clearForm();
					break;
			}
		}
		
		private function clearForm():void
		{
			userForm.user = null;
			userForm.username.text = '';
			userForm.password.text = '';
		}
	}
}