/*
 PureMVC Flex/CF Demo – Query a CFC 
 Copyright (c) 2007 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.cf.querycfc.model
{
	import mx.rpc.IResponder;
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	import org.puremvc.as3.demos.flex.cf.querycfc.model.vo.UserVO;
	
	public class RemoteProxy extends Proxy implements IProxy, IResponder
	{
		private var remoteDelegate:RemoteDelegate;
		
		public static const NAME:String = "RemoteProxy";
		
		public function RemoteProxy()
		{
			super( NAME, new ArrayCollection );
			
			/**
			 * Flex Build Path Output folder on server.  If renaming directories
			 * ensure the below URL is amended accordingly!
			 */
			remoteDelegate = new RemoteDelegate( this, 'QueryCFC.Services.cfc.UserManager' );
			
			refreshData();
		}
		
		public function refreshData():void
		{
			// Clear the Users Array
			users.removeAll();
			
			// Resend for all database data
			remoteDelegate.getAll();
		}

		// Return data property cast to proper type
		public function get users():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		// Result from Remote Call
		public function result( event:Object ):void
		{	
			switch ( event.token.message.operation )
			{
				case "getAllUsers":
					 for each ( var user:Object in event.result )
					 {
					   	var u:UserVO = new UserVO();
					   	
						u.user_id = user.user_id;
						u.username = user.username;
						u.password = user.password;
						
						users.addItem( u );
				 	 }
					 break;
					 
				case "addUser":
					 refreshData();
					 break;
					 
				case "updateUser":
					 break;
					 
				case "deleteUser":
					 break;
			}		 
		}
		
		// Fault from remote Call
		public function fault( info:Object ):void
		{
			trace( info.fault.faultString );
		}
		
		// Add an item to the data
		public function addItem( item:Object ):void
		{
			var user:UserVO = item as UserVO;
			remoteDelegate.callCFC( "addUser", user );
		}
		
		// update an item in the data
		public function updateItem( item:Object ):void
		{
			var user:UserVO = item as UserVO;
			for ( var i:int=0; i<users.length; i++ )
			{
				if ( users[i].user_id == user.user_id ) {
					remoteDelegate.callCFC( "updateUser", user );
					users[i] = user;
				}
			}
		}
		
		// Delete an item in the data
		public function deleteItem( item:Object ):void
		{
			var user:UserVO = item as UserVO;
			for( var i:int=0; i<users.length; i++ )
			{
				if( users[i].user_id == user.user_id ) {
					remoteDelegate.callCFC( "deleteUser", user );
					users.removeItemAt( i );
				}
			}
		}

	}
}