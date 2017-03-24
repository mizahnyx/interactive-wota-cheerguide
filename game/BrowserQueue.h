#pragma once

#include <Urho3D/Core/Context.h>
#include <Urho3D/Scene/Component.h>
#include <string>

namespace Urho3D
{

class URHO3D_API BrowserQueue : public Component
{
    URHO3D_OBJECT(BrowserQueue, Component);
    
public:
    /// Construct.
    BrowserQueue(Context* context);
    /// Destruct.
    virtual ~BrowserQueue();
    /// Register object factory.
    static void RegisterObject(Context* context);
    /// Return a string.
    std::string GetTestString();
};

}
