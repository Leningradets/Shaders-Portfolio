using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.SceneManagement;

public class PostFXActivator : MonoBehaviour
{
    [SerializeField] private Blit _blitFX;
    [SerializeField] private bool _activate;

    private void OnValidate()
    {
        _blitFX.Enabled = _activate;

    }

    
}
