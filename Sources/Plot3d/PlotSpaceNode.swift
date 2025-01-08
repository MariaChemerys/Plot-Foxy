//
//  PlotSpaceNode.swift
//  Plot3D
//
//  Created by Shant Tokatyan on 12/19/19.
//  Copyright © 2019 Stokaty. All rights reserved.
//

import Foundation
import SceneKit

/**
 The node that is the parent for all of the points being plotted and visual planes, graphs, and axis.
 */
public class PlotSpaceNode: SCNNode {
    
    // MARK: - Properties
    
    // Axis
    /// The height of the cylinder for the x axis.
    let xAxisHeight: CGFloat
    /// The height of the cylinder for the positive x axis.
    let xPositiveAxisHeight: CGFloat
    /// The height of the cylinder for the negative x axis.
    let xNegativeAxisHeight: CGFloat
    /// The height of the cylinder for the y axis.
    let yAxisHeight: CGFloat
    /// The height of the cylinder for the positive y axis.
    let yPositiveAxisHeight: CGFloat
    /// The height of the cylinder for the negative y axis.
    let yNegativeAxisHeight: CGFloat
    /// The height of the cylinder for the z axis.
    let zAxisHeight: CGFloat
    /// The height of the cylinder for the positive z axis.
    let zPositiveAxisHeight: CGFloat
    /// The height of the cylinder for the negative z axis.
    let zNegativeAxisHeight: CGFloat
    /// The radius of the cylinder for each axis.
    let axisRadius: CGFloat
    /// The radius of the cyclinder for each gridline.
    let gridlineRadius: CGFloat
    /// The geometry of the positive x axis.
    let xPositiveAxis: SCNGeometry
    /// The geometry of the negative x axis.
    let xNegativeAxis: SCNGeometry
    /// The geometry of the positive y axis.
    let yPositiveAxis: SCNGeometry
    /// The geometry of the negative y axis.
    let yNegativeAxis: SCNGeometry
    /// The geometry of the positive z axis.
    let zPositiveAxis: SCNGeometry
    /// The geometry of the negative z axis.
    let zNegativeAxis: SCNGeometry
    /// The node for the positive x axis.
    let xPositiveAxisNode: SCNNode
    /// The node for the negative x axis.
    let xNegativeAxisNode: SCNNode
    /// The node for the positive y axis.
    let yPositiveAxisNode: SCNNode
    /// The node for the negative y axis.
    let yNegativeAxisNode: SCNNode
    /// The node for the positive z axis.
    let zPositiveAxisNode: SCNNode
    /// The node for the negative z axis.
    let zNegativeAxisNode: SCNNode
    /// The geometry of the origin node.
    let originGeometry: SCNGeometry
    
    /// The root node for the x axis tick marks.
    var xTickMarksNode = SCNNode()
    /// The root node for the y axis tick marks.
    var yTickMarksNode = SCNNode()
    /// The root node for the z axis tick marks.
    var zTickMarksNode = SCNNode()
    
    /// The node for the x axis title.
    var xAxisTitleNode = SCNNode()
    /// The node for the y axis title.
    var yAxisTitleNode = SCNNode()
    /// The node for the z axis title.
    var zAxisTitleNode = SCNNode()
    
    // Axis Arrows
    /// The geometry of the arrow on the x axis.
    let xAxisArrow: SCNGeometry
    /// The geometry of the arrow on the y axis.
    let yAxisArrow: SCNGeometry
    /// The geometry of the arrow on the z axis.
    let zAxisArrow: SCNGeometry
    
    /// The node for the arrow on the positive x axis.
    let xPositiveArrowNode: SCNNode
    /// The node for the arrow on the negative x axis.
    let xNegativeArrowNode: SCNNode
    /// The node for the arrow on the positive y axis.
    let yPositiveArrowNode: SCNNode
    /// The node for the arrow on the negative y axis.
    let yNegativeArrowNode: SCNNode
    /// The node for the arrow on the positive z axis.
    let zPositiveArrowNode: SCNNode
    /// The node for the arrow on the negative z axis.
    let zNegativeArrowNode: SCNNode
    
    // Planes
    /// The plane that is one unit in size to show the xy plane.
    let unitPlaneXY: SCNGeometry
    /// The plane that is one unit in size to show the xz plane.
    let unitPlaneXZ: SCNGeometry
    /// The plane that is one unit in size to show the yz plane.
    let unitPlaneYZ: SCNGeometry
    /// The node for the xy unit plane.
    let unitPlaneXYNode: SCNNode
    /// The node for the xz unit plane.
    let unitPlaneXZNode: SCNNode
    /// The node for the yz unit plane.
    let unitPlaneYZNode: SCNNode
    
    /// The geometry for the wall on the xy plane.
    let wallXY: SCNGeometry
    /// The geometry for the wall on the xz plane.
    let wallXZ: SCNGeometry
    /// The geometry for the wall on the yz plane.
    let wallYZ: SCNGeometry
    /// The geometry for the wall on the xy plane.
    let wallXYNode: SCNNode
    /// The geometry for the wall on the xz plane.
    let wallXZNode: SCNNode
    /// The geometry for the wall on the yz plane.
    let wallYZNode: SCNNode
    
    /// The horizontal gridlines on the XY plane.
    public private(set) var gridLinesHorizontalXY = [SCNNode]()
    /// The horizontal gridlines on the XZ plane.
    public private(set) var gridLinesHorizontalXZ = [SCNNode]()
    public private(set) var gridLinesHorizontalPositiveXZ = [SCNNode]()
    public private(set) var gridLinesHorizontalNegativeXZ = [SCNNode]()
    /// The horizontal gridlines on the YZ plane.
    public private(set) var gridLinesHorizontalYZ = [SCNNode]()
    public private(set) var gridLinesHorizontalPositiveYZ = [SCNNode]()
    public private(set) var gridLinesHorizontalNegativeYZ = [SCNNode]()
    /// The vertical gridlines on the XY plane.
    public private(set) var gridLinesVerticalXY = [SCNNode]()
    /// The vertical gridlines on the XZ plane.
    public private(set) var gridLinesVerticalXZ = [SCNNode]()
    public private(set) var gridLinesVerticalPositiveXZ = [SCNNode]()
    public private(set) var gridLinesVerticalNegativeXZ = [SCNNode]()
    /// The vertical gridlines on the YZ plane.
    public private(set) var gridLinesVerticalYZ = [SCNNode]()
    
    /// The max value on the x axis (the value at the arrow).
    private var xMax: CGFloat
    /// The max value on the y axis (the value at the arrow).
    private var yMax: CGFloat
    /// The max value on the z axis (the value at the arrow).
    private var zMax: CGFloat
    /// The min value on the x axis (the value at the origin).
    private var xMin: CGFloat
    /// The min value on the y axis (the value at the origin).
    private var yMin: CGFloat
    /// The min value on the z axis (the value at the origin).
    private var zMin: CGFloat
    
    // Plotting
    /// The root node of all of the plotted points.
    private var plotPointRootNode: SCNNode
    /// The plotted points.
    private var plottedPoints = [SCNNode]()
    
    weak var dataSource: PlotDataSource?
    weak var delegate: PlotDelegate?
    /// The `PlotView` that has the scene that this `PlotSpaceNode` is in.
    weak var plotView: PlotView?
    
    // Highlights
    /// The radius of each highlight that connects a point to each plane.
    var highlightRadius: CGFloat = 0.01
    /// The color of each highlight that connects a point to each plane.
    var highlightColor: UIColor = .yellow
    /// The root node of all of the highlight nodes.
    private var highlightRootNode: SCNNode
    /// A dictionary keeping track of which nodes are already highlighted.
    private var highlightedIndexes = [Int:Bool]()
    
    // Connections
    /// All of the nodes of the connections that are added on the plot.
    private var connectionNodes = [SCNNode]()
    /// The root node of all of the plotted connections.
    private var connectionRootNode: SCNNode
    
    private var plotConfig: PlotConfiguration
    
    // MARK: - Init
    
    /**
     Initialize a `PlotSpaceNode` with the given configuration.
     - parameter config: The configuration that defines the attributes to use.
     */
    init(config: PlotConfiguration) {
        
        plotConfig = config
        
        xAxisHeight = config.xAxisHeight
        xPositiveAxisHeight = xAxisHeight / (abs(config.xMax) + abs(config.xMin)) * abs(config.xMax)
        xNegativeAxisHeight = xAxisHeight / (abs(config.xMax) + abs(config.xMin)) * abs(config.xMin)
        
        yAxisHeight = config.yAxisHeight
        yPositiveAxisHeight = yAxisHeight / (abs(config.yMax) + abs(config.yMin)) * abs(config.yMax)
        yNegativeAxisHeight = yAxisHeight / (abs(config.yMax) + abs(config.yMin)) * abs(config.yMin)
        
        zAxisHeight = config.zAxisHeight
        zPositiveAxisHeight = zAxisHeight / (abs(config.zMax) + abs(config.zMin)) * abs(config.zMax)
        zNegativeAxisHeight = zAxisHeight / (abs(config.zMax) + abs(config.zMin)) * abs(config.zMin)
        
        axisRadius = config.axisRadius
        gridlineRadius = config.gridlineRadius
        
        xPositiveAxis = SCNCylinder(radius: axisRadius, height: xPositiveAxisHeight)
        xNegativeAxis = SCNCylinder(radius: axisRadius, height: xNegativeAxisHeight)
        
        yPositiveAxis = SCNCylinder(radius: axisRadius, height: yPositiveAxisHeight)
        yNegativeAxis = SCNCylinder(radius: axisRadius, height: yNegativeAxisHeight)
        
        zPositiveAxis = SCNCylinder(radius: axisRadius, height: zPositiveAxisHeight)
        zNegativeAxis = SCNCylinder(radius: axisRadius, height: zNegativeAxisHeight)
        
        xAxisArrow = SCNCone(topRadius: 0, bottomRadius: config.arrowBottomRadius, height: config.arrowHeight)
        yAxisArrow = SCNCone(topRadius: 0, bottomRadius: config.arrowBottomRadius, height: config.arrowHeight)
        zAxisArrow = SCNCone(topRadius: 0, bottomRadius: config.arrowBottomRadius, height: config.arrowHeight)
        
        xPositiveAxisNode = SCNNode(geometry: xPositiveAxis)
        xNegativeAxisNode = SCNNode(geometry: xNegativeAxis)
        yPositiveAxisNode = SCNNode(geometry: yPositiveAxis)
        yNegativeAxisNode = SCNNode(geometry: yNegativeAxis)
        zPositiveAxisNode = SCNNode(geometry: zPositiveAxis)
        zNegativeAxisNode = SCNNode(geometry: zNegativeAxis)
        
        xPositiveArrowNode = SCNNode(geometry: xAxisArrow)
        xNegativeArrowNode = SCNNode(geometry: xAxisArrow)
        yPositiveArrowNode = SCNNode(geometry: yAxisArrow)
        yNegativeArrowNode = SCNNode(geometry: yAxisArrow)
        zPositiveArrowNode = SCNNode(geometry: zAxisArrow)
        zNegativeArrowNode = SCNNode(geometry: zAxisArrow)
        
        originGeometry = SCNSphere(radius: axisRadius)
                
        let xGridSpacing = PlotSpaceNode.coordinate(forValue: config.xTickInterval,
                                                    axisMaxValue: config.xMax,
                                                    axisMinValue: config.xMin,
                                                    axisHeight: config.xAxisHeight)
        let yGridSpacing = PlotSpaceNode.coordinate(forValue: config.yTickInterval,
                                                    axisMaxValue: config.yMax,
                                                    axisMinValue: config.yMin,
                                                    axisHeight: config.yAxisHeight)
        let zGridSpacing = PlotSpaceNode.coordinate(forValue: config.zTickInterval,
                                                    axisMaxValue: config.zMax,
                                                    axisMinValue: config.zMin,
                                                    axisHeight: config.zAxisHeight)
        
        unitPlaneXY = SCNPlane(width: xGridSpacing, height: yGridSpacing)
        unitPlaneXZ = SCNPlane(width: xGridSpacing, height: zGridSpacing)
        unitPlaneYZ = SCNPlane(width: zGridSpacing, height: yGridSpacing)
        unitPlaneXYNode = SCNNode(geometry: unitPlaneXY)
        unitPlaneXZNode = SCNNode(geometry: unitPlaneXZ)
        unitPlaneYZNode = SCNNode(geometry: unitPlaneYZ)
        
        wallXY = SCNBox(width: xAxisHeight, height: yAxisHeight, length: config.planeThickness, chamferRadius: 0)
        wallXZ = SCNBox(width: xAxisHeight, height: zAxisHeight, length: config.planeThickness, chamferRadius: 0)
        wallYZ = SCNBox(width: zAxisHeight, height: yAxisHeight, length: config.planeThickness, chamferRadius: 0)
        wallXYNode = SCNNode(geometry: wallXY)
        wallXZNode = SCNNode(geometry: wallXZ)
        wallYZNode = SCNNode(geometry: wallYZ)
        
        plotPointRootNode = SCNNode()
        highlightRootNode = SCNNode()
        connectionRootNode = SCNNode()
        
        xMax = config.xMax
        yMax = config.yMax
        zMax = config.zMax
        xMin = config.xMin
        yMin = config.yMin
        zMin = config.zMin
                
        super.init()
        
        setupAxis()
        setupUnitPlanes(xGridSpacing: xGridSpacing, yGridSpacing: yGridSpacing, zGridSpacing: zGridSpacing, config: config)
        
        // xy grid lines
        gridLinesHorizontalXY += addGridLines(rootNode: xPositiveAxisNode, spacing: yGridSpacing, direction: PlotAxis.x.negativeDirection, color: config.xyGridColor, positiveAxisHeight: yPositiveAxisHeight, negativeAxisHeight: yNegativeAxisHeight, axisLength: xPositiveAxisHeight)
        gridLinesHorizontalXY += addGridLines(rootNode: xNegativeAxisNode, spacing: yGridSpacing, direction: PlotAxis.x.negativeDirection, color: config.xyGridColor, positiveAxisHeight: yPositiveAxisHeight, negativeAxisHeight: yNegativeAxisHeight, axisLength: xNegativeAxisHeight)
        
        gridLinesVerticalXY += addGridLines(rootNode: yPositiveAxisNode, spacing: xGridSpacing, direction: PlotAxis.x.direction, color: config.xyGridColor, positiveAxisHeight: xPositiveAxisHeight, negativeAxisHeight: xNegativeAxisHeight, axisLength: yPositiveAxisHeight)
        gridLinesVerticalXY += addGridLines(rootNode: yNegativeAxisNode, spacing: xGridSpacing, direction: PlotAxis.x.direction, color: config.xyGridColor, positiveAxisHeight: xPositiveAxisHeight, negativeAxisHeight: xNegativeAxisHeight, axisLength: yNegativeAxisHeight)
        
        // xz grid lines
        gridLinesHorizontalPositiveXZ += addGridLines(rootNode: xPositiveAxisNode, spacing: zGridSpacing, direction: PlotAxis.z.direction, color: config.xzGridColor, positiveAxisHeight: zPositiveAxisHeight, negativeAxisHeight: zNegativeAxisHeight, axisLength: xPositiveAxisHeight)
        gridLinesHorizontalNegativeXZ += addGridLines(rootNode: xNegativeAxisNode, spacing: zGridSpacing, direction: PlotAxis.z.direction, color: config.xzGridColor, positiveAxisHeight: zPositiveAxisHeight, negativeAxisHeight: zNegativeAxisHeight, axisLength: xNegativeAxisHeight)
        
        gridLinesHorizontalXZ.append(contentsOf: gridLinesHorizontalPositiveXZ)
        gridLinesHorizontalXZ.append(contentsOf: gridLinesHorizontalNegativeXZ)
        
        gridLinesVerticalPositiveXZ += addGridLines(rootNode: zPositiveAxisNode, spacing: xGridSpacing, direction: PlotAxis.x.direction, color: config.xzGridColor, positiveAxisHeight: xPositiveAxisHeight, negativeAxisHeight: xNegativeAxisHeight, axisLength: zPositiveAxisHeight)
        gridLinesVerticalNegativeXZ += addGridLines(rootNode: zNegativeAxisNode, spacing: xGridSpacing, direction: PlotAxis.x.direction, color: config.xzGridColor, positiveAxisHeight: xPositiveAxisHeight, negativeAxisHeight: xNegativeAxisHeight, axisLength: zNegativeAxisHeight)
        
        gridLinesVerticalXZ.append(contentsOf: gridLinesVerticalPositiveXZ)
        gridLinesVerticalXZ.append(contentsOf: gridLinesVerticalNegativeXZ)
        
        // yz grid lines
        gridLinesHorizontalPositiveYZ += addGridLines(rootNode: zPositiveAxisNode, spacing: yGridSpacing, direction: PlotAxis.z.negativeDirection, color: config.yzGridColor, positiveAxisHeight: yPositiveAxisHeight, negativeAxisHeight: yNegativeAxisHeight, axisLength: zPositiveAxisHeight)
        gridLinesHorizontalNegativeYZ += addGridLines(rootNode: zNegativeAxisNode, spacing: yGridSpacing, direction: PlotAxis.z.negativeDirection, color: config.yzGridColor, positiveAxisHeight: yPositiveAxisHeight, negativeAxisHeight: yNegativeAxisHeight, axisLength: zNegativeAxisHeight)
        
        gridLinesHorizontalYZ.append(contentsOf: gridLinesHorizontalPositiveYZ)
        gridLinesHorizontalYZ.append(contentsOf: gridLinesHorizontalNegativeYZ)
        
        gridLinesVerticalYZ += addGridLines(rootNode: yPositiveAxisNode, spacing: zGridSpacing, direction: PlotAxis.z.direction, color: config.yzGridColor, positiveAxisHeight: zPositiveAxisHeight, negativeAxisHeight: zNegativeAxisHeight, axisLength: yPositiveAxisHeight)
        gridLinesVerticalYZ += addGridLines(rootNode: yNegativeAxisNode, spacing: zGridSpacing, direction: PlotAxis.z.direction, color: config.yzGridColor, positiveAxisHeight: zPositiveAxisHeight, negativeAxisHeight: zNegativeAxisHeight, axisLength: yNegativeAxisHeight)

        
        addWall(plane: .xy, color: config.xyPlaneColor)
        addWall(plane: .xz, color: config.xzPlaneColor)
        addWall(plane: .yz, color: config.yzPlaneColor)
        
        addChildNode(plotPointRootNode)
        addChildNode(highlightRootNode)
        addChildNode(connectionRootNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    /**
     Sets up each axis and adds them as a child node.
     - parameter axisHeight: The height of each axis.
     */
    private func setupAxis() {
        addPositiveAxisNode(axisNode: xPositiveAxisNode, axisHeight: xPositiveAxisHeight, axis: .x)
        addPositiveArrowNode(arrowNode: xPositiveArrowNode, axisNode: xPositiveAxisNode, axisHeight: xPositiveAxisHeight)
        
        addNegativeAxisNode(axisNode: xNegativeAxisNode, axisHeight: xNegativeAxisHeight, axis: .x)
        xNegativeArrowNode.eulerAngles = SCNVector3(Double.pi, 0, 0)
        addNegativeArrowNode(arrowNode: xNegativeArrowNode, axisNode: xNegativeAxisNode, axisHeight: xNegativeAxisHeight)

        addPositiveAxisNode(axisNode: yPositiveAxisNode, axisHeight: yPositiveAxisHeight, axis: .y)
        addPositiveArrowNode(arrowNode: yPositiveArrowNode, axisNode: yPositiveAxisNode, axisHeight: yPositiveAxisHeight)

        addNegativeAxisNode(axisNode: yNegativeAxisNode, axisHeight: yNegativeAxisHeight, axis: .y)
        yNegativeArrowNode.eulerAngles = SCNVector3(Double.pi, 0, 0)
        addNegativeArrowNode(arrowNode: yNegativeArrowNode, axisNode: yNegativeAxisNode, axisHeight: yNegativeAxisHeight)

        addPositiveAxisNode(axisNode: zPositiveAxisNode, axisHeight: zPositiveAxisHeight, axis: .z)
        addPositiveArrowNode(arrowNode: zPositiveArrowNode, axisNode: zPositiveAxisNode, axisHeight: zPositiveAxisHeight)
        
        addNegativeAxisNode(axisNode: zNegativeAxisNode, axisHeight: zNegativeAxisHeight, axis: .z)
        zNegativeArrowNode.eulerAngles = SCNVector3(0, 0, Double.pi)
        addNegativeArrowNode(arrowNode: zNegativeArrowNode, axisNode: zNegativeAxisNode, axisHeight: zNegativeAxisHeight)

        originGeometry.materials.first!.diffuse.contents = UIColor.white
        let originNode = SCNNode(geometry: originGeometry)
        originNode.position = SCNVector3(0, 0, 0)
        addChildNode(originNode)
    }
    
    /**
     Sets up the unit planes for each axis and adds them as child nodes.
     - parameters:
        - xGridSpacing: The spacing between gridlines on the x axis.
        - yGridSpacing: The spacing between gridlines on the y axis.
        - zGridSpacing: The spacing between gridlines on the z axis.
        - config: The configuration which contains the colors to use for each grid.
     */
    private func setupUnitPlanes(xGridSpacing: CGFloat, yGridSpacing: CGFloat, zGridSpacing: CGFloat, config: PlotConfiguration) {
        let xOffset = xGridSpacing/2
        let yOffset = yGridSpacing/2
        let zOffset = zGridSpacing/2
        
        unitPlaneXY.materials.first!.diffuse.contents = config.xyUnitPlaneColor
        unitPlaneXYNode.position = SCNVector3(xPositiveAxisHeight > 0 ? xOffset : -xOffset, yPositiveAxisHeight > 0 ? yOffset : -yOffset, 0)
        addChildNode(unitPlaneXYNode)
        
        unitPlaneXZ.materials.first!.diffuse.contents = config.xzUnitPlaneColor
        unitPlaneXZNode.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
        unitPlaneXZNode.position = SCNVector3(xPositiveAxisHeight > 0 ? xOffset : -xOffset, 0, zPositiveAxisHeight > 0 ? zOffset : -zOffset)
        addChildNode(unitPlaneXZNode)
        
        unitPlaneYZ.materials.first!.diffuse.contents = config.yzUnitPlaneColor
        unitPlaneYZNode.eulerAngles = SCNVector3(0, Double.pi/2, 0)
        unitPlaneYZNode.position = SCNVector3(0, yPositiveAxisHeight > 0 ? yOffset : -yOffset, zPositiveAxisHeight > 0 ? zOffset : -zOffset)
        addChildNode(unitPlaneYZNode)
    }
    
    /**
     Adds gridlines along a specified axis direction and returns an array of nodes containing these gridlines.
     Gridlines are added both positively and negatively along the specified axis from the origin.
     - parameters:
        - rootNode: The node to which the gridlines will be added as children.
        - spacing: The distance between each gridline.
        - direction: The direction in which the gridlines extend (e.g., along the x, y, or z axis).
        - color: The color of the gridlines.
        - positiveAxisHeight: The extent of the gridlines in the positive direction along the axis.
        - negativeAxisHeight: The extent of the gridlines in the negative direction along the axis.
        - axisLength: The length of each gridline along its thickness direction (perpendicular to the grid).
     - returns: An array of `SCNNode` instances representing each gridline that was added to the root node.
     */
    private func addGridLines(rootNode: SCNNode, spacing: CGFloat, direction: SCNVector3, color: UIColor, positiveAxisHeight: CGFloat, negativeAxisHeight: CGFloat, axisLength: CGFloat) -> [SCNNode] {
        var positiveLineCount = 0
        if !(positiveAxisHeight / spacing).isNaN {
            positiveLineCount = Int(positiveAxisHeight / spacing)
        }
        var negativeLineCount = 0
        if !(negativeAxisHeight / spacing).isNaN {
            negativeLineCount = Int(negativeAxisHeight / spacing)
        }
        var gridLines = [SCNNode]()
        
        for i in 0..<positiveLineCount {
            let gridLinePositive = SCNCylinder(radius: gridlineRadius, height: axisLength)
            gridLinePositive.materials.first!.diffuse.contents = color
            let gridLineNodePositive = SCNNode(geometry: gridLinePositive)
            let position = spacing * CGFloat(i + 1)
            gridLineNodePositive.position = SCNVector3(position, position, position) * direction
            rootNode.addChildNode(gridLineNodePositive)
            gridLines.append(gridLineNodePositive)
        }
        
        for i in 0..<negativeLineCount {
            let gridLineNegative = SCNCylinder(radius: gridlineRadius, height: axisLength)
            gridLineNegative.materials.first!.diffuse.contents = color
            let gridLineNodeNegative = SCNNode(geometry: gridLineNegative)
            let position = spacing * CGFloat(i + 1)
            gridLineNodeNegative.position = SCNVector3(-position, -position, -position) * direction
            rootNode.addChildNode(gridLineNodeNegative)
            gridLines.append(gridLineNodeNegative)
        }
        return gridLines
    }
    
    /**
     Updates the gridline tick marks by first removing the existing ones, and then delegating to the instances plot delegate to add new tick marks.
     */
    private func updateTickMarks() {
        xTickMarksNode.removeFromParentNode()
        yTickMarksNode.removeFromParentNode()
        zTickMarksNode.removeFromParentNode()
        
        xTickMarksNode = SCNNode()
        yTickMarksNode = SCNNode()
        zTickMarksNode = SCNNode()
        
        addChildNode(xTickMarksNode)
        addChildNode(yTickMarksNode)
        addChildNode(zTickMarksNode)
        
        guard let delegate = delegate else {
            return
        }
        
        // x
        fillTickMarksNode(tickMarksNode: xTickMarksNode, gridLinesArray: gridLinesVerticalPositiveXZ, axis: .x)
        fillTickMarksNode(tickMarksNode: xTickMarksNode, gridLinesArray: gridLinesVerticalNegativeXZ, axis: .x)
        
        // y
        fillTickMarksNode(tickMarksNode: yTickMarksNode, gridLinesArray: gridLinesHorizontalPositiveYZ, axis: .y)
        fillTickMarksNode(tickMarksNode: yTickMarksNode, gridLinesArray: gridLinesHorizontalNegativeYZ, axis: .y)
        
        // z
        fillTickMarksNode(tickMarksNode: zTickMarksNode, gridLinesArray: gridLinesHorizontalPositiveXZ, axis: .z)
        fillTickMarksNode(tickMarksNode: zTickMarksNode, gridLinesArray: gridLinesHorizontalNegativeXZ, axis: .z)
    }
    
    /**
     Fills the provided tick marks node with labels at each tick mark position along a specified axis.
     - parameters:
        - tickMarksNode: The node to which the tick mark labels will be added.
        - gridLinesArray: An array of gridline nodes that determine the positions of tick marks along the axis.
        - axis: The axis for which tick marks are being created (x, y, or z).
    */
    private func fillTickMarksNode(tickMarksNode: SCNNode, gridLinesArray: [SCNNode], axis: PlotAxis) {
        for (index, gridline) in gridLinesArray.enumerated() {
            
            var position: Float = 0
            let text: PlotText
            
            let xAxisLastPositiveIndex = Int(round(plotConfig.xMax / plotConfig.xTickInterval))
            let yAxisLastPositiveIndex = Int(round(plotConfig.yMax / plotConfig.yTickInterval))
            let zAxisLastPositiveIndex = Int(round(plotConfig.zMax / plotConfig.zTickInterval))
            
            // Formatter function to handle number display
            func formattedValue(_ value: CGFloat) -> String {
                if value == floor(value) {
                    return String(Int(value)) // Whole number
                } else {
                    return String(format: "%.1f", value) // Fractional number
                }
            }
            
            switch axis {
            case .x:
                position = gridline.position.x
                let tickValue: CGFloat
                if index < xAxisLastPositiveIndex {
                    tickValue = CGFloat(index + 1) * plotConfig.xTickInterval
                } else {
                    tickValue = -CGFloat(index - xAxisLastPositiveIndex + 1) * plotConfig.xTickInterval
                }
                text = PlotText(
                    text: formattedValue(tickValue),
                    fontSize: 0.2,
                    offset: 0.2)
                
            case .y:
                position = -gridline.position.z
                let tickValue: CGFloat
                if index < yAxisLastPositiveIndex {
                    tickValue = CGFloat(index + 1) * plotConfig.yTickInterval
                } else {
                    tickValue = -CGFloat(index - yAxisLastPositiveIndex + 1) * plotConfig.yTickInterval
                }
                text = PlotText(
                    text: formattedValue(tickValue),
                    fontSize: 0.2,
                    offset: 0.2)
                
            case .z:
                position = gridline.position.z
                let tickValue: CGFloat
                if index < zAxisLastPositiveIndex {
                    tickValue = CGFloat(index + 1) * plotConfig.zTickInterval
                } else {
                    tickValue = -CGFloat(index - zAxisLastPositiveIndex + 1) * plotConfig.zTickInterval
                }
                text = PlotText(
                    text: formattedValue(tickValue),
                    fontSize: 0.2,
                    offset: 0.2)
            }
            
            let textNode = text.node
            textNode.eulerAngles = tickMarkTextRotation(forAxis: axis)
            
            switch axis {
            case .x:
                textNode.position = SCNVector3(CGFloat(position), 0, zPositiveAxisHeight + text.offset)
            case .y:
                textNode.position = SCNVector3(0, CGFloat(position), zPositiveAxisHeight + text.offset)
            case .z:
                textNode.position = SCNVector3(xPositiveAxisHeight + text.offset, 0, CGFloat(position))
            }
            tickMarksNode.addChildNode(textNode)
        }
    }
    
    /**
     Adds the wall for the given plane.
     - parameters:
        - plane: The plane for the wall to be added on.
        - color: The color of the wall go add.
     */
    private func addWall(plane: PlotPlane, color: UIColor) {
        setWall(plane, color: color)
        
        var axisW: CGFloat
        var axisH: CGFloat
        
        switch plane {
        case .xy:
            axisW = xAxisHeight/2
            axisH = yAxisHeight/2
        case .xz:
            axisW = xAxisHeight/2
            axisH = zAxisHeight/2
        case .yz:
            axisW = yAxisHeight/2
            axisH = zAxisHeight/2
        }
        
        var wallNode: SCNNode
        switch plane {
        case .xy:
            wallNode = wallXYNode
            wallNode.position = SCNVector3((xPositiveAxisHeight - xNegativeAxisHeight) / 2, (yPositiveAxisHeight - yNegativeAxisHeight) / 2, 0)
        case .xz:
            wallNode = wallXZNode
            wallNode.eulerAngles = SCNVector3(-Double.pi/2, 0, 0)
            wallNode.position = SCNVector3((xPositiveAxisHeight - xNegativeAxisHeight) / 2, 0, (zPositiveAxisHeight - zNegativeAxisHeight) / 2)
        case .yz:
            wallNode = wallYZNode
            wallNode.eulerAngles = SCNVector3(0, Double.pi/2, 0)
            wallNode.position = SCNVector3(0, (yPositiveAxisHeight - yNegativeAxisHeight) / 2, (zPositiveAxisHeight - zNegativeAxisHeight) / 2)
        }
        
        addChildNode(wallNode)
    }
    
    // MARK: - Plotting
    
    /**
     Connects the nodes corresponding to the given index.
     - parameters:
        - index0: The index of the node where the connection begins.
        - index1: The index of the node where the connection ends.
        - connection: The attributes for the connection.
     
     */
    func connectPoints(index0: Int, index1: Int, connection: PlotConnection) {
        let node0 = plottedPoints[index0]
        let node1 = plottedPoints[index1]
        let diffVector = node1.position - node0.position
        
        let connectionLength = CGFloat(diffVector.length())
        let connectionGeometry = SCNCylinder(radius: connection.radius, height: connectionLength)
        connectionGeometry.materials.first!.diffuse.contents = connection.color
        
        let connectionNode = SCNNode(geometry: connectionGeometry)
        connectionNode.position = node0.position.midPoint(to: node1.position)
        connectionNode.eulerAngles = node0.position.eulerAngles(to: node1.position)
        
        connectionNodes.append(connectionNode)
        connectionRootNode.addChildNode(connectionNode)
    }
    
    /**
     Calculates the scene coordinate for a value on an axis in a plot space.
     - parameters:
        - value: The value to convert to a scene coordinate.
        - axisMaxValue: The max value of the axis.
        - axisMinValue: The min value of the axis.
        - axisHeight: the scene height of the axis.
     
     - returns: The float that corresponds to a coordinate on an axis in the scene.
     */
    private static func coordinate(forValue value: CGFloat, axisMaxValue: CGFloat, axisMinValue: CGFloat, axisHeight: CGFloat) -> CGFloat {
        return value * (axisHeight/(axisMaxValue - axisMinValue))
    }
    
    /**
     Plots the given point of raw data into the scene.
     
     The given point should not be modified for the scene.
     The plot point will be converted to scene coordinate using `self.coordinate(_:)`.
     
     - parameters:
        - point: The raw data point to plot.
        - geometry: The geometry of the node plotted in the scene for the given coordinate.
     
     */
    private func plot(_ point: PlotPoint, geometry: SCNGeometry?) {
        let pointNode = PlotPointNode(geometry: geometry, index: plottedPoints.count)
        let x = PlotSpaceNode.coordinate(forValue: point.x, axisMaxValue: xMax, axisMinValue: xMin, axisHeight: xAxisHeight)
        let y = PlotSpaceNode.coordinate(forValue: point.y, axisMaxValue: yMax, axisMinValue: yMin, axisHeight: yAxisHeight)
        let z = PlotSpaceNode.coordinate(forValue: point.z, axisMaxValue: zMax, axisMinValue: zMin, axisHeight: zAxisHeight)
        pointNode.position = SCNVector3(x, y, z)
        
        plottedPoints.append(pointNode)
        plotPointRootNode.addChildNode(pointNode)
    }
    
    /**
     Safely returns the node plotted at the given index.
     - parameter index: the index of that plotted node.
     - returns: an optional reference to the `SCNNode` that is plotted at the given index.
     */
    func plottedPoint(atIndex index: Int) -> SCNNode? {
        guard index < plottedPoints.count, index >= 0 else {
            return nil
        }
        
        return plottedPoints[index]
    }
    
    // MARK: - Update Plot
    
    /**
     Adds any new connections that might be required after the last call to `PlotNewPoints`.
     
     This function is intended for cases where most of the data has already been plotted, and only a relatively lesser amount of additional connections need to be added.
     */
    func addNewConnections() {
        guard let dataSource = dataSource, let delegate = delegate, let plotView = plotView else {
            return
        }
        
        let currentConnectionCount = connectionNodes.count
        let additionalConnectionCount = dataSource.numberOfConnections() - currentConnectionCount
        
        guard additionalConnectionCount > 0 else {
            return
        }
        
        let startIndex = currentConnectionCount
        for index in startIndex..<startIndex+additionalConnectionCount {
            guard let pointsToConnect = delegate.plot(plotView, pointsToConnectAt: index),
                let connection = delegate.plot(plotView, connectionAt: index)
                else {
                continue
            }
            connectPoints(index0: pointsToConnect.p0, index1: pointsToConnect.p1, connection: connection)
        }
    }
    
    /**
     Plots any points that were added aftter the latest call to `plotNewPoints`.
     
     This function is intended for cases where most of the data has already been plotted, and only a relatively lesser amount of additional points need to be plotted.
     */
    func addNewPlotPoints() {
        guard let dataSource = dataSource, let delegate = delegate, let plotView = plotView else {
            return
        }
        
        let currentPointCount = plottedPoints.count
        let additionalPointCount = dataSource.numberOfPoints() - currentPointCount
        
        guard additionalPointCount > 0 else {
            return
        }
        
        let startIndex = currentPointCount
        for index in 0..<additionalPointCount {
            let plotPoint = delegate.plot(plotView, pointForItemAt: index + startIndex)
            let geometry = delegate.plot(plotView, geometryForItemAt: index + startIndex)
            plot(plotPoint, geometry: geometry)
        }
    }
    
    /**
     Reloads all of the connections that need to be added to the plot.
     - parameter numberOfConnections: The number of connections that need to be added.
     */
    func reloadConnections(_ numberOfConnections: Int) {
        guard let delegate = delegate, let plotView = plotView, numberOfConnections > 0 else {
            return
        }
        
        for index in 0..<numberOfConnections {
            guard let pointsToConnect = delegate.plot(plotView, pointsToConnectAt: index),
                let connection = delegate.plot(plotView, connectionAt: index)
                else {
                continue
            }
            connectPoints(index0: pointsToConnect.p0, index1: pointsToConnect.p1, connection: connection)
        }
    }
    
    /**
    Reloads all of the plot points that need to be added to the plot.
    - parameter numberOfPoints: The number of points that need to be added.
    */
    func reloadPlottedPoints(_ numberOfPoints: Int) {
        guard let delegate = delegate, let plotView = plotView, numberOfPoints > 0 else {
            return
        }
        
        for index in 0..<numberOfPoints {
            let plotPoint = delegate.plot(plotView, pointForItemAt: index)
            let geometry = delegate.plot(plotView, geometryForItemAt: index)
            plot(plotPoint, geometry: geometry)
        }
    }
    
    /**
     Reloads the plotted points using the plot data source and plot delegate.
     
     This function is analagous to a `UITableView`'s `reloadData()` function.
     It will remove all tick marks and all plotted points, and then add new tick marks using its delegate, and plot the new data using the delegate and datasource.
     */
    func reloadData() {
        removeAllPlottedPoints()
        updateTickMarks()
        
        guard let dataSource = dataSource else {
            return
        }
        
        let numberOfPoints = dataSource.numberOfPoints()
        reloadPlottedPoints(numberOfPoints)
        
        let numberOfConnections = dataSource.numberOfConnections()
        reloadConnections(numberOfConnections)
    }
    
    /**
     Removes all of the plotted points from the `PlotSpaceNode` and removes all of the nodes stored in `plottedPoints`.
     Removes all of the connections from the `PlotSpaceNode` and removes all of the nodes stored in `connectionNodes`.
     */
    private func removeAllPlottedPoints() {
        plottedPoints.removeAll()
        plotPointRootNode.removeFromParentNode()
        plotPointRootNode = SCNNode()
        addChildNode(plotPointRootNode)
        
        connectionNodes.removeAll()
        connectionRootNode.removeFromParentNode()
        connectionRootNode = SCNNode()
        addChildNode(connectionRootNode)
    }
    
    /**
     Adds cyclinders that connect the given node to each plane.  Nodes can be highlighted to help the user better see where the node is on the plot.
     - parameter node: The node that is selected for highlight.
     */
    func highlightNode(_ node: PlotPointNode) {
        guard highlightedIndexes[node.index] != true else {
            return
        }
        
        highlightedIndexes[node.index] = true
        let xHighlightGeometry = SCNCylinder(radius: highlightRadius, height: CGFloat(abs(node.position.z)))
        xHighlightGeometry.materials.first!.diffuse.contents = highlightColor
        let xHighlightNode = SCNNode(geometry: xHighlightGeometry)
        xHighlightNode.position = SCNVector3(node.position.x, node.position.y, node.position.z/2)
        xHighlightNode.eulerAngles = highlightRotation(forAxis: .x)
        highlightRootNode.addChildNode(xHighlightNode)
        
        let yHighlightGeometry = SCNCylinder(radius: highlightRadius, height: CGFloat(abs(node.position.x)))
        yHighlightGeometry.materials.first!.diffuse.contents = highlightColor
        let yHighlightNode = SCNNode(geometry: yHighlightGeometry)
        yHighlightNode.position = SCNVector3(node.position.x/2, node.position.y, node.position.z)
        yHighlightNode.eulerAngles = highlightRotation(forAxis: .y)
        highlightRootNode.addChildNode(yHighlightNode)
        
        let zHighlightGeometry = SCNCylinder(radius: highlightRadius, height: CGFloat(abs(node.position.y)))
        zHighlightGeometry.materials.first!.diffuse.contents = highlightColor
        let zHighlightNode = SCNNode(geometry: zHighlightGeometry)
        zHighlightNode.position = SCNVector3(node.position.x, node.position.y/2, node.position.z)
        zHighlightNode.eulerAngles = highlightRotation(forAxis: .z)
        highlightRootNode.addChildNode(zHighlightNode)
    }
    
    /**
     Replaces the `highlightRootNode` with a new node that has no children, and removes all of the stored highlighted indexes.
     */
    func removeHighlights() {
        highlightedIndexes.removeAll()
        highlightRootNode.removeFromParentNode()
        highlightRootNode = SCNNode()
        addChildNode(highlightRootNode)
    }
    
    // MARK: Update Configuration
    
    /**
     Sets the value of `isHidden` for the unit plane on the given `PlotPlane`.
     - parameters:
        - plane: The plane that contains the unit plane is intended for.
        - isHidden: Whether or not the unit plane should be hidden.
     */
    func setUnitPlane(_ plane: PlotPlane, isHidden: Bool) {
        switch plane {
        case PlotPlane.xy:
            unitPlaneXYNode.isHidden = isHidden
        case PlotPlane.xz:
            unitPlaneXZNode.isHidden = isHidden
        case PlotPlane.yz:
            unitPlaneYZNode.isHidden = isHidden
        }
    }
    
    /**
    Sets the value of `isHidden` for the wall on the given `PlotPlane`.
    - parameters:
       - plane: The plane that contains the unit plane is intended for.
       - isHidden: Whether or not the wall should be hidden.
    */
    func setWall(_ plane: PlotPlane, isHidden: Bool) {
        switch plane {
        case PlotPlane.xy:
            wallXYNode.isHidden = isHidden
        case PlotPlane.xz:
            wallXZNode.isHidden = isHidden
        case PlotPlane.yz:
            wallYZNode.isHidden = isHidden
        }
    }
    
    /**
    Sets the color for the wall on the given `PlotPlane`.
    - parameters:
       - plane: The plane that contains the unit plane is intended for.
       - color: The color for the wall.
    */
    func setWall(_ plane: PlotPlane, color: UIColor) {
        switch plane {
        case PlotPlane.xy:
            wallXY.materials.first!.diffuse.contents = color
        case PlotPlane.xz:
            wallXZ.materials.first!.diffuse.contents = color
        case PlotPlane.yz:
            wallYZ.materials.first!.diffuse.contents = color
        }
    }
    
    // MARK: - Labels

    /**
     Sets a title for the given axis.
     - parameters:
        - axis: The axis to set a title for.
        - plotText: The PlotText object to use to generate the node for the axis title.
    */
    func setAxisTitle(_ axis: PlotAxis,
                      plotText: PlotText) {
        var axisTitleNode: SCNNode
        var axisHeight: CGFloat
        var axisPosition: CGFloat
        switch axis {
        case .x:
            axisHeight = zPositiveAxisHeight
            axisPosition = xPositiveAxisHeight > 0 ? xPositiveAxisHeight : -xNegativeAxisHeight
        case .y:
            axisHeight = zPositiveAxisHeight
            axisPosition = yPositiveAxisHeight > 0 ? yPositiveAxisHeight : -yNegativeAxisHeight
        case .z:
            axisHeight = xPositiveAxisHeight
            axisPosition = zPositiveAxisHeight > 0 ? zPositiveAxisHeight : -zNegativeAxisHeight
        }
        
        let axisAndOffset = plotText.offset + axisHeight
        switch axis {
        case .x:
            xAxisTitleNode.removeFromParentNode()
            xAxisTitleNode = plotText.node
            axisTitleNode = xAxisTitleNode
            axisTitleNode.position = SCNVector3(axisPosition / 2, 0, axisAndOffset)
        case .y:
            yAxisTitleNode.removeFromParentNode()
            yAxisTitleNode = plotText.node
            axisTitleNode = yAxisTitleNode
            axisTitleNode.position = SCNVector3(0, axisPosition / 2, axisAndOffset)
            
        case .z:
            zAxisTitleNode.removeFromParentNode()
            zAxisTitleNode = plotText.node
            axisTitleNode = zAxisTitleNode
            axisTitleNode.position = SCNVector3(axisAndOffset, 0, axisPosition / 2)
        }
        
        axisTitleNode.eulerAngles = axisTextRotation(forAxis: axis)
        addChildNode(axisTitleNode)
    }
}


