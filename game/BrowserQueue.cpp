#include "BrowserQueue.h"

const char* LOGIC_CATEGORY = "Logic";

namespace Urho3D
{

BrowserQueue::BrowserQueue(Context* context)
    :Component(context)
{
}

BrowserQueue::~BrowserQueue()
{
}

std::string BrowserQueue::GetTestString()
{
    return "Patito\n";
}

void BrowserQueue::RegisterObject(Context* context)
{
    context->RegisterFactory<BrowserQueue>(LOGIC_CATEGORY);
}

}
