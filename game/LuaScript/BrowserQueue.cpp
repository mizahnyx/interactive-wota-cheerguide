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

#include "BrowserQueue.h"

/* function to register type */
static void tolua_reg_types (lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"BrowserQueue :Component");
 tolua_usertype(tolua_S,"URHO3D_API");
}

/* Open function */
TOLUA_API int tolua_BrowserQueue_open (lua_State* tolua_S)
{
 tolua_open(tolua_S);
 tolua_reg_types(tolua_S);
 tolua_module(tolua_S,NULL,0);
 tolua_beginmodule(tolua_S,NULL);
 tolua_cclass(tolua_S,"URHO3D_API","URHO3D_API","BrowserQueue :Component",NULL);
 tolua_beginmodule(tolua_S,"URHO3D_API");
 tolua_endmodule(tolua_S);
 tolua_endmodule(tolua_S);
 return 1;
}


#if defined(LUA_VERSION_NUM) && LUA_VERSION_NUM >= 501
 TOLUA_API int luaopen_BrowserQueue (lua_State* tolua_S) {
 return tolua_BrowserQueue_open(tolua_S);
};
#endif

