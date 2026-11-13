using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Move requires the GameObject to have a Rigidbody component
[RequireComponent(typeof(Rigidbody))]

public class PlayerMove : MonoBehaviour
{


    // Update is called once per frame
    void Update()
    {
        if (((Input.mousePosition.x > (Screen.width * 0.75f)) && Input.GetMouseButton(0)) || Input.GetKey(KeyCode.D) || Input.GetKey(KeyCode.RightArrow))
        {
            GetComponent<Rigidbody>().AddForce(new Vector3(10, 0, 0));
        }
        else if (((Input.mousePosition.x <= (Screen.width * 0.25f)) && Input.GetMouseButton(0))|| Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.LeftArrow))
        {
            GetComponent<Rigidbody>().AddForce(new Vector3(-10, 0, 0));
        }
        if (((Input.mousePosition.y > (Screen.height * 0.75f)) && Input.GetMouseButton(0))|| Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.UpArrow))
        {
            GetComponent<Rigidbody>().AddForce(new Vector3(0, 0, 10));
        }
        else if (((Input.mousePosition.y <= (Screen.height * 0.25f)) && Input.GetMouseButton(0))|| Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.DownArrow))
        {
            GetComponent<Rigidbody>().AddForce(new Vector3(0, 0, -10));
        }
    }
}
