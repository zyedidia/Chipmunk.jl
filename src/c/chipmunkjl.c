#include <chipmunk.h>
#include <stdlib.h>

cpSpaceDebugDrawOptions* cpjlDebugDrawOptions(cpSpaceDebugDrawCircleImpl drawCircle,
					     cpSpaceDebugDrawSegmentImpl drawSegment,
					     cpSpaceDebugDrawFatSegmentImpl drawFatSegment,
					     cpSpaceDebugDrawPolygonImpl drawPolygon,
					     cpSpaceDebugDrawDotImpl drawDot,
					     cpSpaceDebugDrawFlags flags,
					     cpSpaceDebugColor outlineColor,
					     cpSpaceDebugDrawColorForShapeImpl colorForShape,
					     cpSpaceDebugColor constraintColor,
					     cpSpaceDebugColor collisionPointColor,
					     cpDataPointer data) {
	cpSpaceDebugDrawOptions* options = malloc(sizeof(cpSpaceDebugDrawOptions));
	options->drawCircle = drawCircle;
	options->drawSegment = drawSegment;
	options->drawFatSegment = drawFatSegment;
	options->drawPolygon = drawPolygon;
	options->drawDot = drawDot;

	options->flags = flags;
	options->shapeOutlineColor = outlineColor;
	options->colorForShape = colorForShape;
	options->constraintColor = constraintColor;
	options->collisionPointColor = collisionPointColor;

	options->data = data;

	return options;
}
