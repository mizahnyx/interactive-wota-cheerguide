#pragma once

#include <Urho3D/Core/Context.h>
#include <Urho3D/Scene/Component.h>
#include <deque>
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
    /// Return the number of pending incoming messages (for Urho3D).
    int Count();
    /// Receive a message (for Urho3D).
    std::string Receive();
    /// Send a message (for Urho3D).
    void Send(std::string message);
    /// Return the number of pending incoming messages (for browser).
    static int StaticCount();
    /// Receive a message (for browser).
    static std::string StaticReceive();
    /// Send a message (for browser)
    static void StaticSend(std::string message);

private:
    static std::deque<std::string> in;
    static std::deque<std::string> out;
};

}
