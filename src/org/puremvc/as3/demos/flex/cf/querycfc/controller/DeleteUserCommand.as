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

	import org.puremvc.as3.demos.flex.cf.querycfc.*;
	import org.puremvc.as3.demos.flex.cf.querycfc.model.*;
	import org.puremvc.as3.demos.flex.cf.querycfc.model.vo.*;
	
	public class DeleteUserCommand extends SimpleCommand implements ICommand
	{
		override public function execute( note:INotification ):void
		{
			var selectedUser:UserVO = note.getBody() as UserVO;
			
			var remoteProxy:RemoteProxy = facade.retrieveProxy( RemoteProxy.NAME ) as RemoteProxy;
			
			// Delete Item in Database
			remoteProxy.deleteItem( selectedUser );
			
			sendNotification( ApplicationFacade.USER_DELETED );
		}
		
	}
}