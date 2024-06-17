#include <raylib.h>

#define MAX_RECTANGLES 300
#define RL_TRUE 1
#define RL_FALSE 0

static Rectangle rectangles[MAX_RECTANGLES];
static int currentRectangleCount = 0;

void b_ClearBackground(int r, int g, int b, int a)
{
    ClearBackground((Color){r, g, b});
}
void b_DrawText(
    const char* text,
    int x, int y, int size,
    int r, int g, int b, int a)
{
    DrawText(text, x, y, size, (Color){r, g, b, a});
}
int b_IsKeyDown(int key)
{
    return IsKeyDown(key) ? RL_TRUE : RL_FALSE;
}
int b_IsKeyPressed(int key)
{
    return IsKeyPressed(key) ? RL_TRUE : RL_FALSE;
}
bool b_CheckCollisionCircleRec(int centerX, int centerY, float radius, unsigned int rect)
{
    return CheckCollisionCircleRec((Vector2){centerX, centerY}, radius, rectangles[rect]);
}
void b_DrawRectangle(
    int x, int y,
    int width, int height,
    int r, int g, int b, int a)
{
    DrawRectangle(x, y, width, height, (Color){r, g, b, a});
}

void b_DrawRectangleRec(unsigned int rec, int r, int g, int b, int a)
{
    DrawRectangleRec(rectangles[rec], (Color){r, g, b, a});
}
void b_DrawCircle(int x, int y, float radius, int r, int g, int b, int a)
{
    DrawCircle(x, y, radius, (Color){r, g, b, a});
}
void b_DrawPixel(int x, int y, int r, int g, int b, int a)
{
    DrawPixel(x, y, (Color){r, g, b, a});
}


unsigned int b_CreateRectangle(int x, int y, int w, int h)
{
    int current = currentRectangleCount++;
    rectangles[current].x = x;
    rectangles[current].y = y;
    rectangles[current].width = w;
    rectangles[current].height = h;
    return current;
}
void b_RectangleSetX(unsigned int rectangle, int x)
{
    rectangles[rectangle].x = x;
}
void b_RectangleSetY(unsigned int rectangle, int y)
{
    rectangles[rectangle].y = y;
}
int b_RectangleGetX(unsigned int rectangle)
{
    return rectangles[rectangle].x;
}
int b_RectangleGetY(unsigned int rectangle)
{
    return rectangles[rectangle].y;
}
void b_RectangleSetXY(unsigned int rectangle, int x, int y)
{
    rectangles[rectangle].x = x;
    rectangles[rectangle].y = y;
}
void b_RectangleSetWidth(unsigned int rectangle, unsigned int width)
{
    rectangles[rectangle].width = width;
}
void b_RectangleSetHeight(unsigned int rectangle, unsigned int height)
{
    rectangles[rectangle].height = height;
}
int b_CheckCollisionRecs(unsigned int rec1, unsigned int rec2)
{
    return CheckCollisionRecs(rectangles[rec1], rectangles[rec2]) ? RL_TRUE : RL_FALSE;
}
// Second rect takes separated arguments
int b_CheckCollisionRecs2(unsigned int rec1, int x, int y, int width, int height)
{
    return CheckCollisionRecs(rectangles[rec1], (Rectangle){x, y, width, height}) ? RL_TRUE : RL_FALSE;
}