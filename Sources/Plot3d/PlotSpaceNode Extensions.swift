//
//  PlotSpaceNode Extensions.swift
//  Plot3d
//
//  Created by Mariia Chemerys on 07.11.2024.
//

import Foundation
import SceneKit

// MARK: - Axis Nodes

extension PlotSpaceNode {
    /**
     Adds a positive axis node along the specified axis with the given height.
     Positions and rotates the axis node to align along the positive direction of the specified axis.
     - parameters:
        - axisNode: The node representing the positive axis line.
        - axisHeight: The length of the axis in the positive direction.
        - axis: The axis along which the node will be positioned (x, y, or z).
     */
    func addPositiveAxisNode(axisNode: SCNNode, axisHeight: CGFloat, axis: PlotAxis) {
        switch axis {
        case .x:
            axisNode.position = SCNVector3(axisHeight/2, 0, 0)
            axisNode.eulerAngles = SCNVector3(0, 0, -Double.pi/2)
        case .y:
            axisNode.position = SCNVector3(0, axisHeight/2, 0)
        case .z:
            axisNode.position = SCNVector3(0, 0, axisHeight/2)
            axisNode.eulerAngles = SCNVector3(Double.pi/2, 0, 0)
        }
        addChildNode(axisNode)
    }
    
    /**
     Adds a negative axis node along the specified axis with the given height.
     Positions and rotates the axis node to align along the negative direction of the specified axis.
     - parameters:
        - axisNode: The node representing the negative axis line.
        - axisHeight: The length of the axis in the negative direction.
        - axis: The axis along which the node will be positioned (x, y, or z).
     */
    func addNegativeAxisNode(axisNode: SCNNode, axisHeight: CGFloat, axis: PlotAxis) {
        switch axis {
        case .x:
            axisNode.position = SCNVector3(-axisHeight/2, 0, 0)
            axisNode.eulerAngles = SCNVector3(0, 0, -Double.pi/2)
        case .y:
            axisNode.position = SCNVector3(0, -axisHeight/2, 0)
        case .z:
            axisNode.position = SCNVector3(0, 0, -axisHeight/2)
            axisNode.eulerAngles = SCNVector3(Double.pi/2, 0, 0)
        }
        addChildNode(axisNode)
    }
}

// MARK: - Arrow Nodes

extension PlotSpaceNode {
    /**
     Adds an arrow node to the end of the positive axis, if the axis has a positive height.
     Positions the arrow at the end of the positive axis direction.
     - parameters:
        - arrowNode: The node representing the arrowhead.
        - axisNode: The node representing the axis line, to which the arrowhead will be added.
        - axisHeight: The length of the axis in the positive direction.
     */
    func addPositiveArrowNode(arrowNode: SCNNode, axisNode: SCNNode, axisHeight: CGFloat) {
        if axisHeight > 0 {
            arrowNode.position = SCNVector3(0, axisHeight/2, 0)
            axisNode.addChildNode(arrowNode)
        }
    }
    
    /**
     Adds an arrow node to the end of the negative axis, if the axis has a negative height.
     Positions the arrow at the end of the negative axis direction.
     - parameters:
        - arrowNode: The node representing the arrowhead.
        - axisNode: The node representing the axis line, to which the arrowhead will be added.
        - axisHeight: The length of the axis in the negative direction.
     */
    func addNegativeArrowNode(arrowNode: SCNNode, axisNode: SCNNode, axisHeight: CGFloat) {
        if axisHeight > 0 {
            arrowNode.position = SCNVector3(0, -axisHeight/2, 0)
            axisNode.addChildNode(arrowNode)
        }
    }
}

// MARK: - Rotations

extension PlotSpaceNode {
    /**
     Calculates the rotation needed for axis labels to face the viewer based on the specified axis.
     - parameter axis: The axis along which the label is positioned (x, y, or z).
     - returns: A `SCNVector3` rotation vector that aligns text to face outward from the axis.
     */
    func axisTextRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, 0, 0)
        case .y:
           return SCNVector3(-Double.pi/2, 0, -Double.pi/2)
        case .z:
            return SCNVector3(-Double.pi/2, Double.pi/2, 0)
        }
    }
    
    /**
     Calculates the rotation needed for highlighting elements along the specified axis.
     - parameter axis: The axis along which the highlight element is positioned (x, y, or z).
     - returns: A `SCNVector3` rotation vector that aligns highlights along the axis.
     */
    func highlightRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, 0, 0)
        case .y:
           return SCNVector3(0, 0, -Double.pi/2)
        case .z:
            return SCNVector3(0, 0, 0)
        }
    }
    
    /**
     Calculates the rotation needed for tick mark labels to face the viewer based on the specified axis.
     - parameter axis: The axis along which the tick marks are positioned (x, y, or z).
     - returns: A `SCNVector3` rotation vector that aligns tick mark labels to face outward from the axis.
     */
    func tickMarkTextRotation(forAxis axis: PlotAxis) -> SCNVector3 {
        switch axis {
        case .x:
            return SCNVector3(-Double.pi/2, Double.pi/2, 0)
        case .y:
           return SCNVector3(-Double.pi/2, Double.pi/2, -Double.pi/2)
        case .z:
            return SCNVector3(-Double.pi/2, Double.pi*2, 0)
        }
    }
}
