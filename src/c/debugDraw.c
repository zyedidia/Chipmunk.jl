#include <stdio.h>
#include <chipmunk.h>
#include <SFML/Graphics.h>

void drawCircle(cpVect pos, cpFloat angle, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data) {
	printf("radius: %f\n", radius);
	sfCircleShape* circle = sfCircleShape_create();
	sfCircleShape_setRadius(circle, radius);
	sfVector2f sfPos = {pos.x, -pos.y};
	sfVector2f origin = {radius, radius};
	sfCircleShape_setOrigin(circle, origin);
	sfCircleShape_setPosition(circle, sfPos);
	sfCircleShape_setRotation(circle, -angle * 180/3.14159);
	sfColor sfFillColor = sfColor_fromRGBA(255 * fillColor.r, 255 * fillColor.g, 255 * fillColor.b, 255 * fillColor.a);
	printf("Color: %d %d %d %d\n", sfFillColor.r, sfFillColor.g, sfFillColor.b, sfFillColor.a);
	sfCircleShape_setFillColor(circle, sfFillColor);
	sfColor sfOutlineColor = sfColor_fromRGBA(255 * outlineColor.r, 255 * outlineColor.g, 255 * outlineColor.b, 255 * outlineColor.a);
	sfCircleShape_setOutlineColor(circle, sfOutlineColor);

	sfRenderWindow_drawCircleShape((sfRenderWindow*) data, circle, NULL);
	sfCircleShape_destroy(circle);
}

cpSpaceDebugColor colorForShape(cpShape* shape, cpDataPointer data) {
	cpSpaceDebugColor color = {1.0f, 0.0f, 0.0f, 1.0f};
	return color;
}

int main() {
	sfVideoMode mode = {800, 600, 32};
	sfRenderWindow* window = sfRenderWindow_create(mode, "Chipmunk Debug", sfResize | sfClose, NULL);
	sfRenderWindow_setFramerateLimit(window, 60);
	sfEvent event;

	cpVect gravity = cpv(0, -100);
	cpBody* body = cpBodyNew(1, 1);
	cpShape* shape = cpCircleShapeNew(body, 20, cpv(400, 0));

	cpSpace* space = cpSpaceNew();
	cpSpaceSetGravity(space, gravity);

	cpSpaceAddBody(space, body);
	cpSpaceAddShape(space, shape);

	cpFloat timestep = 1./60;

	cpSpaceDebugDrawOptions drawOptions = {
		drawCircle,
		NULL,
		NULL,
		NULL,
		NULL,

		(cpSpaceDebugDrawFlags)(CP_SPACE_DEBUG_DRAW_SHAPES | CP_SPACE_DEBUG_DRAW_CONSTRAINTS | CP_SPACE_DEBUG_DRAW_COLLISION_POINTS),

		{200.0f/255.0f, 210.0f/255.0f, 230.0f/255.0f, 1.0f},
		colorForShape,
		{0.0f, 0.75f, 0.0f, 1.0f},
		{1.0f, 0.0f, 0.0f, 1.0f},
		window,
	};

	printf("Size: %d\n", sizeof(cpSpaceDebugColor));

	while (1) {
		while (sfRenderWindow_pollEvent(window, &event)) {
			if (event.type == sfEvtClosed)
				sfRenderWindow_close(window);
		}

		sfRenderWindow_clear(window, sfWhite);

		cpSpaceStep(space, timestep);
		cpVect pos = cpBodyGetPosition(body);

		cpSpaceDebugDraw(space, &drawOptions);

		sfRenderWindow_display(window);
	}

	return 0;
}
