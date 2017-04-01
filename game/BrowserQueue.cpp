#include "BrowserQueue.h"
#include <emscripten/bind.h>

const char* LOGIC_CATEGORY = "Logic";

namespace Urho3D
{
    std::deque<std::string> BrowserQueue::in;
    std::deque<std::string> BrowserQueue::out;
    
    BrowserQueue::BrowserQueue(Context* context)
        :Component(context)
    {
    }

    BrowserQueue::~BrowserQueue()
    {
    }

    void BrowserQueue::RegisterObject(Context* context)
    {
        context->RegisterFactory<BrowserQueue>(LOGIC_CATEGORY);
    }

    int BrowserQueue::Count()
    {
        return in.size();
    }

    std::string BrowserQueue::Receive()
    {
        std::string result = in.front();
        in.pop_front();
        return result;
    }

    void BrowserQueue::Send(std::string message)
    {
        out.push_back(message);
    }
    
    int BrowserQueue::StaticCount()
    {
        return out.size();
    }
   
    std::string BrowserQueue::StaticReceive()
    {
        std::string result = out.front();
        out.pop_front();
        return result;
    }

    void BrowserQueue::StaticSend(std::string message)
    {
        in.push_back(message);
    }
}

int BrowserQueueCount()
{
    return Urho3D::BrowserQueue::StaticCount();
}

std::string BrowserQueueReceive()
{
    return Urho3D::BrowserQueue::StaticReceive();
}

void BrowserQueueSend(std::string message)
{
    return Urho3D::BrowserQueue::StaticSend(message);
}

EMSCRIPTEN_BINDINGS(browser_queue) {
    emscripten::function("BrowserQueueCount", &BrowserQueueCount);
    emscripten::function("BrowserQueueReceive", &BrowserQueueReceive);
    emscripten::function("BrowserQueueSend", &BrowserQueueSend);
}
