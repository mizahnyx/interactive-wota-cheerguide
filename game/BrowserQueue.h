#pragma once

#include <Urho3D/Core/Context.h>
#include <Urho3D/Scene/Component.h>

namespace Urho3D
{

class URHO3D_API BrowserQueue : public Component
{
    URHO3D_OBJECT(BrowserQueue, Component);
    
public:
    // Construct.
    BrowserQueue(Context* context);
    // Destruct.
    virtual ~BrowserQueue();
};

}
