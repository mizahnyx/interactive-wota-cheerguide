/*
** Lua binding: BrowserQueue
*/

#ifndef __cplusplus
#include "stdlib.h"
#endif
#include "string.h"

#include "tolua++.h"

/* Exported function */
TOLUA_API int tolua_BrowserQueue_open (lua_State* tolua_S);

#include "../BrowserQueue.h"
using namespace Urho3D;
#pragma warning(disable:4800)

/* function to release collected object via destructor */
#ifdef __cplusplus

static int tolua_collect_BrowserQueue (lua_State* tolua_S)
{
 BrowserQueue* self = (BrowserQueue*) tolua_tousertype(tolua_S,1,0);
 Mtolua_delete(self);
 return 0;
}
#endif


/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"Component");
 tolua_usertype(tolua_S,"BrowserQueue");
 tolua_usertype(tolua_S,"Context");
}

/* method: new of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_new00
static int tolua_BrowserQueue_BrowserQueue_new00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertable(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_isusertype(tolua_S,2,"Context",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Context* context = ((Context*)  tolua_tousertype(tolua_S,2,0));
 {
  BrowserQueue* tolua_ret = (BrowserQueue*)  Mtolua_new((BrowserQueue)(context));
  tolua_pushusertype(tolua_S,(void*)tolua_ret,"BrowserQueue");
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: new_local of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_new00_local
static int tolua_BrowserQueue_BrowserQueue_new00_local(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertable(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_isusertype(tolua_S,2,"Context",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  Context* context = ((Context*)  tolua_tousertype(tolua_S,2,0));
 {
  BrowserQueue* tolua_ret = (BrowserQueue*)  Mtolua_new((BrowserQueue)(context));
  tolua_pushusertype(tolua_S,(void*)tolua_ret,"BrowserQueue");
 tolua_register_gc(tolua_S,lua_gettop(tolua_S));
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'new'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: delete of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_delete00
static int tolua_BrowserQueue_BrowserQueue_delete00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  BrowserQueue* self = (BrowserQueue*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'delete'", NULL);
#endif
 Mtolua_delete(self);
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'delete'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Count of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_Count00
static int tolua_BrowserQueue_BrowserQueue_Count00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  BrowserQueue* self = (BrowserQueue*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Count'", NULL);
#endif
 {
  int tolua_ret = (int)  self->Count();
 tolua_pushnumber(tolua_S,(lua_Number)tolua_ret);
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Count'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Receive of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_Receive00
static int tolua_BrowserQueue_BrowserQueue_Receive00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,2,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  BrowserQueue* self = (BrowserQueue*)  tolua_tousertype(tolua_S,1,0);
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Receive'", NULL);
#endif
 {
  std::string tolua_ret = (std::string)  self->Receive();
 tolua_pushcppstring(tolua_S,(const char*)tolua_ret);
 }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Receive'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: Send of class  BrowserQueue */
#ifndef TOLUA_DISABLE_tolua_BrowserQueue_BrowserQueue_Send00
static int tolua_BrowserQueue_BrowserQueue_Send00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
 !tolua_isusertype(tolua_S,1,"BrowserQueue",0,&tolua_err) ||
 !tolua_iscppstring(tolua_S,2,0,&tolua_err) ||
 !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
 goto tolua_lerror;
 else
#endif
 {
  BrowserQueue* self = (BrowserQueue*)  tolua_tousertype(tolua_S,1,0);
  std::string message = ((std::string)  tolua_tocppstring(tolua_S,2,0));
#ifndef TOLUA_RELEASE
 if (!self) tolua_error(tolua_S,"invalid 'self' in function 'Send'", NULL);
#endif
 {
  self->Send(message);
 }
 }
 return 0;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'Send'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* Open function */
TOLUA_API int tolua_BrowserQueue_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
 #ifdef __cplusplus
 tolua_cclass(tolua_S,"BrowserQueue","BrowserQueue","Component",tolua_collect_BrowserQueue);
 #else
 tolua_cclass(tolua_S,"BrowserQueue","BrowserQueue","Component",NULL);
 #endif
 tolua_beginmodule(tolua_S,"BrowserQueue");
  tolua_function(tolua_S,"new",tolua_BrowserQueue_BrowserQueue_new00);
  tolua_function(tolua_S,"new_local",tolua_BrowserQueue_BrowserQueue_new00_local);
  tolua_function(tolua_S,".call",tolua_BrowserQueue_BrowserQueue_new00_local);
  tolua_function(tolua_S,"delete",tolua_BrowserQueue_BrowserQueue_delete00);
  tolua_function(tolua_S,"Count",tolua_BrowserQueue_BrowserQueue_Count00);
  tolua_function(tolua_S,"Receive",tolua_BrowserQueue_BrowserQueue_Receive00);
  tolua_function(tolua_S,"Send",tolua_BrowserQueue_BrowserQueue_Send00);
 tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_BrowserQueue (lua_State* tolua_S) {
 return tolua_BrowserQueue_open(tolua_S);
};
#endif

