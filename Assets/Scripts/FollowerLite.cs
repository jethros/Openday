using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowerLite : MonoBehaviour
{
    //The GameObject to follow
    public GameObject target;
    //At what distance to start following
    float followStartDistance = 5.0f;
    //How fast to follow
    float followSpeed = 0.02f;
    //Target Spotted.
    public bool targetSpotted = false;

    private void Update()
    {       
        TargetDistanceCheck();
        //If target is spotted
        if (targetSpotted)
        {
            Move();
        }  
    }

    void TargetDistanceCheck()
    {
        //Distance between target and this Gameobject
        float distance = Vector3.Distance(target.transform.position, transform.position);
        //If target distance is less than that specified, the condition is true
        if (distance < followStartDistance)
        {
            targetSpotted = true;
        }
        else
        {
            targetSpotted = false;
        }
    }

    void Move()
    {
        //Move this GameObject towards target at the given speed 
        transform.position = Vector3.MoveTowards(transform.position, target.transform.position, followSpeed);
        //Face Target
        transform.LookAt(target.transform);
    }

}
